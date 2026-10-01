-- Washington State EV Population Analysis
-- Advanced SQL Analysis

USE ev_population_analysis;
-- Rank EV manufacturers by total number of records

WITH manufacturer_counts AS (
    SELECT
        Make,
        COUNT(*) AS ev_count
    FROM ev_population
    GROUP BY Make
)
SELECT
    Make,
    ev_count,
    RANK() OVER (ORDER BY ev_count DESC) AS rank_by_make
FROM manufacturer_counts;

-- Top 3 EV models within each manufacturer

WITH ev_by_each_manufacturer AS (
    SELECT
        Make,
        Model,
        COUNT(*) AS ev_count
    FROM ev_population
    GROUP BY Make, Model
),
count_by_model_rank AS (
    SELECT
        Make,
        Model,
        ev_count,
        RANK() OVER (
            PARTITION BY Make
            ORDER BY ev_count DESC
        ) AS model_rank
    FROM ev_by_each_manufacturer
)
SELECT
    Make,
    Model,
    ev_count,
    model_rank
FROM count_by_model_rank
WHERE model_rank <= 3;
