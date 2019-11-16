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
    door_count float,
    seat_count float,
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
PUZZLE 4

*/



/*
PUZZLE 5

*/



/*
PUZZLE 6

*/

