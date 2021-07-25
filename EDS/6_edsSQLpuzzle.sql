/*
Database: edsSQLChalls
Dataset: secondary car market

PUZZLE 6 - Nested Queries and Putting It All Together
For each maker and model combination, display:

- The earliest manufacture year
- The latest manufacture year
- The most common number of doors (1 mode)
- The most common number of seats (1 mode)
- The average displacement, horsepower, and price.
- Format these columns as you see fit for a clean output.

ROUND(AVG(column), #OfDecimals)

When creating your query, do not store any new intermediary tables. In other words,
pretend you do not have write access to the database.
*/

-- Test query for top door and seat combo by maker and model
SELECT c.*
FROM car_structures c
LEFT JOIN car_structures c2
    ON c.maker = c2.maker
    AND c.model = c2.model
    AND c.listings < c2.listings
WHERE c2.listings IS NULL;

-- Full query
SELECT
    stats.*,
    tops.door_count,
    tops.seat_count
FROM (
    SELECT
        c.maker,
        c.model,
        MIN(c.manufacture_year) AS earliest_man_yr,
        MAX(c.manufacture_year) AS latest_man_yr,
        ROUND(AVG(c.displacement), 2) AS avg_disp,
        ROUND(AVG(c.horse_power)) AS avg_hp,
        CONCAT("$", FORMAT(AVG(c.price), 0)) AS avg_price
    FROM carmkt c
    WHERE c.door_count IS NOT NULL AND
        c.seat_count IS NOT NULL
    GROUP BY c.maker, c.model
) stats
LEFT JOIN (
    SELECT s.*
    FROM car_structures s
    LEFT JOIN car_structures s2
        ON s.maker = s2.maker
        AND s.model = s2.model
        AND s.listings < s2.listings
    WHERE s2.listings IS NULL) tops
ON stats.maker = tops.maker
    AND stats.model = tops.model
ORDER BY stats.maker, stats.model;
