/*
Database: edsSQLChalls

Puzzles 4-6 use the secondary car market dataset
Table: carmkt
*/

-- Create the table based on secondary_car_market.csv
CREATE TABLE carmkt (
    maker varchar(15),
    model varchar(20),
    mileage double unsigned,
    manufacture_year int unsigned,
    transmission varchar(5),
    door_count int unsigned,
    seat_count int unsigned,
    displacement float,
    horse_power float,
    price double unsigned
);

-- Load data from secondary_car_market.csv
LOAD DATA INFILE '/Users/heatherkusmierz/MySQLData/secondary_car_market.csv'
INTO TABLE carmkt
FIELDS TERMINATED BY ","
(maker, model, mileage, manufacture_year, transmission,
    @vdoor_count, @vseat_count, displacement, horse_power, price)
SET
door_count = nullif(@vdoor_count, ''),
seat_count = nullif(@vseat_count, '');


/*
PUZZLE 4 - Data Cleaning
By default, on import, the door_count and seat_count columns will have values of "None". In addition, some values have multiple formats, such as "4" and "4.0". This creates a situation where those columns are saved as type VARCHAR, and aggregations treat "4" and "4.0" as separate values.

- First, replace "None" values in those two columns with NULL
- Then, fix the issue of separate formats for "4" and "4.0" and set those columns as type INTEGER
- Next, create a new table car_structures that has the total number of listings for each maker, model, door count, and seat count combination. The goal of this table will to help us understand which car structures (door count and seat count) are most common for each car model.

As a final check, select from car_structures for Audi 100's. Which structural combination is the most common?

Data cleaning done in pandas, here are SQL commands:

```sql
UPDATE carmkt SET door_count = NULL WHERE door_count = 'None';
UPDATE carmkt SET seat_count = NULL WHERE seat_count = 'None';
ALTER TABLE carmkt MODIFY door_count INTEGER;
ALTER TABLE carmkt MODIFY seat_count INTEGER;
```
*/

CREATE TABLE IF NOT EXISTS car_structures (
    SELECT maker, model, door_count, seat_count, COUNT(*) AS listings
    FROM carmkt
    WHERE door_count IS NOT NULL AND seat_count IS NOT NULL
    GROUP BY maker, model, door_count, seat_count
);

SELECT * FROM car_structures
WHERE maker = 'audi' AND model = '100';


/*
PUZZLE 5 - Self Joins and Modes
Create a query to select the most common car structures (door count and seat count combination) for each Audi model. How many doors and seats does the typical Audi A2 have? Do not store this output in a new table.

Tip: There are many different ways to accomplish. We recommend taking advantage of the car_structures table from Puzzle 1.
*/

-- Get all listings by maker and model
SELECT maker, model, door_count, seat_count, SUM(listings) AS total_listings
FROM car_structures
WHERE maker = 'audi'
GROUP BY model, door_count, seat_count
ORDER BY model, total_listings DESC;

-- Get only the top number of listings for each maker/model combo
SELECT c.maker, c.model, c.door_count, c.seat_count, SUM(c.listings)
FROM car_structures c
WHERE c.maker = 'audi'
GROUP BY c.model, c.door_count, c.seat_count
HAVING SUM(c.listings) =
    (SELECT SUM(c2.listings)
     FROM car_structures c2
     WHERE c2.maker = c.maker AND
        c2.model = c.model
     GROUP BY c2.model, c2.door_count, c2.seat_count
     ORDER BY SUM(c2.listings) DESC
     LIMIT 1)
ORDER BY c.model;

--GROUP BY c.model, c.door_count, c.seat_count
/*
PUZZLE 6 - Nested Queries and Putting It All Together
For each maker and model combination, display:

    The earliest manufacture year
    The latest manufacture year
    The most common number of doors (1 mode)
    The most common number of seats (1 mode)
    The average displacement, horsepower, and price.
    Format these columns as you see fit for a clean output.

When creating your query, do not store any new intermediary tables. In other words, pretend you do not have write access to the database.
*/

SELECT maker, model, MIN(manufacture_year) AS earliest_man_yr,
    MAX(manufacture_year) AS latest_man_yr,
    -- most common doors
    -- most common seats
    AVG(displacement) AS avg_disp,
    AVG(horsepower) AS avg_hp,
    AVG(price) AS avg_price
FROM carmkt
GROUP BY maker, model
