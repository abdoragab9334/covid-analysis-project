 COVID-19 Global Dashboard with Power BI

This project presents an interactive Power BI dashboard that analyzes global COVID-19 data using real-world datasets. It includes key metrics such as total cases, deaths, infection and vaccination rates by country and continent.

---

 Tools & Technologies Used
- **Power BI Desktop**: For data visualization and dashboard creation
- **SQL Server**: To preprocess and aggregate large datasets
- **DAX (Data Analysis Expressions)**: For calculated columns and KPIs
- **GitHub**: To version-control and publish the final project

---

 Dashboard Features
- KPIs: Total Cases, Total Deaths, Infection Rate (%), Death Rate (%), Vaccination Rate (%), Deaths per Population (%)
- Interactive filters (slicers) by **Date**, **Continent**, and **Country**
- Global map showing COVID-19 spread by continent
- Bar charts by location and continent
- Trend lines for daily new cases, deaths, and vaccinations
- Custom tooltips and responsive visuals

---

 Key DAX Measures
- **Infection Rate** = Total Cases / Population
- **Death Rate** = Total Deaths / Total Cases
- **Vaccination Rate** = Total Vaccinations / Population
- **Deaths per Population** = Total Deaths / Population

---

 Data Processing Workflow
1. Cleaned and aggregated raw COVID-19 data using SQL queries
2. Imported data into Power BI via SQL Server
3. Created relationships between tables (deaths, vaccinations)
4. Built custom DAX measures for KPIs
5. Designed dashboard layout with a focus on clarity and visual balance

---

 Challenges Faced
- **Data inconsistencies** between vaccination and death datasets
- Handling **missing or null values** for population or vaccinations
- Creating **responsive visuals** that update based on slicers
- Designing a layout that balances **information density** and **readability**

---
