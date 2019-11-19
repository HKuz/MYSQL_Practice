/*
Database: edsSQLChalls

Puzzles 7-9 use the foot-moneyball datasets
Tables: [ ]
*/

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


/*
PUZZLE 7

*/



/*
PUZZLE 8

*/



/*
PUZZLE 9

*/

