/*
Database: edsSQLChalls
Dataset: secondary car market

PUZZLE 5 - Self Joins and Modes
Create a query to select the most common car structures (door count and seat count
combination) for each Audi model. How many doors and seats does the typical Audi
A2 have? Do not store this output in a new table.

Tip: There are many different ways to accomplish this. We recommend taking advantage
of the car_structures table from Puzzle 4.
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
