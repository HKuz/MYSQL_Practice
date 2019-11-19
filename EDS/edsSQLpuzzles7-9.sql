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
Write a query that:

- Calculates the average score allowed by a "team" to "opponents" in 2012, in
their home stadium (i.e. location = 'H')
- Calculates the average score allowed by an "opponent" to "teams" in 2012, in
their home stadium (i.e. location = 'A')
- Selects any teams for which the above calculations do not match.

Tip: Remember to account for the possibility of multiple quarterbacks on a team playing in a game.
*/

SELECT
    t_home.*, o_away.avg_team_score
FROM (
    SELECT
        team, AVG(opponent_score) AS avg_op_score
    FROM foot_moneyball
    WHERE YEAR(date)=2012 AND location='H'
    GROUP BY team
) t_home
JOIN (
    SELECT
        opponent, AVG(team_score) AS avg_team_score
    FROM foot_moneyball
    WHERE YEAR(date)=2012 AND location='A'
    GROUP BY opponent
) o_away
ON t_home.team = o_away.opponent
WHERE t_home.avg_op_score <> o_away.avg_team_score;


/*
PUZZLE 8

*/



/*
PUZZLE 9

*/

