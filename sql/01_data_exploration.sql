-- Washington State EV Population Analysis
-- Data Exploration

USE ev_population_analysis;
-- Preview the dataset
SELECT *
FROM ev_population
LIMIT 10;

-- Total number of EV records
SELECT COUNT(*) AS total_ev_records
FROM ev_population;
-- Earliest and latest model year
SELECT
    MIN(`Model Year`) AS earliest_model_year,
    MAX(`Model Year`) AS latest_model_year
FROM ev_population;

-- Number of unique manufacturers
SELECT COUNT(DISTINCT Make) AS total_manufacturers
FROM ev_population;
-- EV records by vehicle type
SELECT
    `Electric Vehicle Type`,
    COUNT(*) AS total_records
FROM ev_population
GROUP BY `Electric Vehicle Type`
ORDER BY total_records DESC;
-- Check for missing or blank city values
SELECT COUNT(*) AS missing_city_records
FROM ev_population
WHERE City IS NULL
   OR TRIM(City) = '';
-- Count records where electric range is zero
SELECT COUNT(*) AS zero_range_records
FROM ev_population
WHERE `Electric Range` = 0;

-- Average electric range, excluding zero values
SELECT
    ROUND(AVG(`Electric Range`), 0) AS avg_ev_range
FROM ev_population
WHERE `Electric Range` != 0;
-- Top 10 EV manufacturers
SELECT
    Make,
    COUNT(*) AS total_ev
FROM ev_population
GROUP BY Make
ORDER BY total_ev DESC
LIMIT 10;
-- Top 10 EV models
SELECT
    Model,
    COUNT(*) AS count_models
FROM ev_population
GROUP BY Model
ORDER BY count_models DESC
LIMIT 10;
