/*
Database: edsSQLChalls
Code to create tables and load data

Puzzles 1-3 use the box office dataset
Puzzles 4-6 use the secondary car market dataset
Puzzle 7 uses the foot-moneyball dataset
*/

-- Create the table
CREATE TABLE boxofc (
    budget double,
    country varchar(35),
    director varchar(35),
    genre varchar(10),
    gross double,
    name varchar(100),
    rating varchar(15),
    runtime smallint(5) unsigned,
    score float,
    star varchar(30),
    studio varchar(75),
    votes int(10) unsigned
);

-- Load data from box_office_predictions.tsv
LOAD DATA INFILE './Datasets/box_office_predictions.tsv' INTO TABLE boxofc;

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

-- Create the table for foot-moneyball.csv
CREATE TABLE foot_moneyball (
    season int unsigned,
    `date` date,
    name varchar(20),
    team char(3),
    team_score int unsigned,
    opponent char(3),
    opponent_score int unsigned,
    location char(1),
    passing_attempts int unsigned,
    completions int unsigned,
    interceptions int unsigned,
    passer_rating float,
    sacks int unsigned,
    sacks_yards_lost int unsigned,
    passing_touchdowns int unsigned,
    passing_yards int signed,
    rushing_attempts int unsigned,
    rushing_touchdowns int unsigned,
    rushing_yards int signed
);

-- Load data from foot-moneyball.csv
LOAD DATA INFILE '/Users/heatherkusmierz/MySQLData/foot-moneyball.csv'
INTO TABLE foot_moneyball
FIELDS TERMINATED BY ",";

-- Create the table for quarterbacks.csv
CREATE TABLE quarterbacks (
    name varchar(20),
    draft_round float,
    college varchar(20)
);

-- Load data from quarterbacks.csv
LOAD DATA INFILE '/Users/heatherkusmierz/MySQLData/quarterbacks.csv'
INTO TABLE quarterbacks
FIELDS TERMINATED BY ","
(name, @vdraft_round, college)
SET
draft_round = nullif(@vdraft_round, '');
