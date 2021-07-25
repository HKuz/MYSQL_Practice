/*
Database: edsSQLChalls
Dataset: secondary car market

PUZZLE 4 - Data Cleaning
By default, on import, the door_count and seat_count columns will have values of
"None". In addition, some values have multiple formats, such as "4" and "4.0".
This creates a situation where those columns are saved as type VARCHAR, and
aggregations treat "4" and "4.0" as separate values.

- First, replace "None" values in those two columns with NULL
- Then, fix the issue of separate formats for "4" and "4.0" and set those columns
as type INTEGER
- Next, create a new table car_structures that has the total number of listings
for each maker, model, door count, and seat count combination. The goal of this
table will be to help us understand which car structures (door count and seat
count) are most common for each car model.

As a final check, select from car_structures for Audi 100's. Which structural
combination is the most common?

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
