select*
from covid..CovidDeaths;
use covid
--select*
--from covid..Covidvaccinations;

-- selecting the data we will use

select location, date, total_cases, new_cases, total_deaths, population
from covid..CovidDeaths
order by 1,2;

--looking at total cases vs total deaths


select (total_deaths/total_cases)
from covid..CovidDeaths;
;
-- i foundout that there is a problem at the data type of the columns(int)

alter table covid..CovidDeaths
alter column total_cases float ;
alter table covid..CovidDeaths
alter column total_deaths float ;

--the problem has been solved successfully

--to know the death rate from covid in egypt:

select location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 death_percentage
from covid..CovidDeaths
where location like '%egypt%';


--looking at total cases vs population:: (the infection percentage)

select location, date, total_cases, new_cases, population, (total_cases/population)*100 infection_rate
from covid..CovidDeaths
where continent is not null
order by 1,2 ;

--looking at the most countries infected vs population:: (the infection percentage)

select location , max (total_cases) max_of_cases , population,max((total_cases/population)*100) infection_rate
from covid..CovidDeaths
where continent is not null
group by location, population
order by infection_rate desc ;

--countries with the heighst death count

select location , max (total_deaths) death_count
from covid..CovidDeaths
where continent is not null
group by location
order by death_count desc ;

--...........................
--numbers worldwide

--cases and deaths per day
select  date, sum (new_cases)cases_per_day,sum(new_deaths)deaths_per_day ,sum (new_deaths)/sum (new_cases)*100 death_percentage
from covid..CovidDeaths
where continent is not null
group by date
order by 1;

-- the query ran successfully but the death percentage was always 0 and that's because the columns datatypes are (int)

--so i had to edit the query and the problem have been solved

select  date, sum (new_cases)cases_per_day,sum(new_deaths)deaths_per_day ,(sum (new_deaths)*1.0/nullif(sum (new_cases),0))*100 death_percentage
from covid..CovidDeaths
where continent is not null
group by date
order by 1;


--another across the world quistion
select   sum (new_cases)cases_per_day,sum(new_deaths)deaths_per_day ,(sum (new_deaths)*1.0/nullif(sum (new_cases),0))*100 death_percentage
from covid..CovidDeaths
where continent is not null
order by 1;


--how many people in the world have been vaccinated?

select dea.continent, dea.location, dea.date, dea.population ,vac.new_vaccinations,
SUM (vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)rollingpeoplevaccinated
from covid..CovidDeaths dea
join covid..Covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 1,2;


	--use cte
	with popvsvac (continent, location, date, population, rollingpeoplevaccinated, new_vaccinations)
	as(
select dea.continent, dea.location, dea.date, dea.population ,vac.new_vaccinations,
SUM (vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)rollingpeoplevaccinated
from covid..CovidDeaths dea
join covid..Covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 1,2
	)
	select*,( cast(rollingpeoplevaccinated as float)/ nullif( population,0)*100) vaccinatedpercentage
	from popvsvac
	where rollingpeoplevaccinated is not null and population is not null;

	
	
	
	
	
	---temp table

	drop table if exists percentpopulationvaccinated
	create table percentpopulationvaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric,
)
insert into percentpopulationvaccinated

select dea.continent, dea.location, dea.date, dea.population ,vac.new_vaccinations,
SUM (vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)rollingpeoplevaccinated
from covid..CovidDeaths dea
join covid..Covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 1,2
	
	select *,( cast(rollingpeoplevaccinated as float)/ nullif( population,0)*100) vaccinatedpercentage
	from percentpopulationvaccinated
	where rollingpeoplevaccinated is not null and population is not null;




	--creating a view to store data for later visualisation
	 

	 create view percent_of_vaccinatedpeople as 
	 select dea.continent, dea.location, dea.date, dea.population ,vac.new_vaccinations,
SUM (vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)rollingpeoplevaccinated
from covid..CovidDeaths dea
join covid..Covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null

	select*
	from percent_of_vaccinatedpeople