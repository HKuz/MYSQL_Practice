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
PUZZLE 5
Create a query to select the most common car structures (door count and seat count combination) for each Audi model. How many doors and seats does the typical Audi A2 have? Do not store this output in a new table.

Tip: There are many different ways to accomplish. We recommend taking advantage of the car_structures table from Puzzle 1.
*/

SELECT maker, model, door_count, seat_count, SUM(listings) AS total_listings
FROM car_structures
WHERE maker = 'audi'
GROUP BY model, door_count, seat_count
ORDER BY total_listings DESC;


/*
PUZZLE 6

*/

