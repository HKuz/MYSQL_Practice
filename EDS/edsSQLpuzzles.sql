/*
Database: edsSQLChalls

Puzzles 1-3 use the box office dataset
Table: boxofc

Puzzles 4-6 use the secondary car market dataset
Table: [ ]

Puzzles 7-9 use the foot-moneyball dataset
Table: [ ]
*/

/*
PUZZLE 1
For each genre, display:

- Total number of movies released
- Average budget
- Average runtime
- Average score
- Percent of movies with over 100K votes

Order your results by the total number of movies released in descending order.
*/

SELECT genre, COUNT(*) AS total_movies,
AVG(budget) AS avg_budget,
AVG(runtime) AS avg_runtime,
AVG(score) AS avg_score,
AVG(CASE WHEN votes > 100000 THEN 1 ELSE 0 END) * 100 AS pct_votes_gt_100K
FROM boxofc
WHERE country = 'USA'
GROUP BY genre
ORDER BY total_movies DESC;

/*
PUZZLE 2
Produce the same table from Puzzle #1, with the following changes:

- Remove genres with under 100 movies released
- Round average runtime to the nearest integer
- Round average score to two decimal places
- Round percent of movies with 100K votes to the nearest percentage point
- Add the gross sales value from the movie with the highest gross sales.
- Display budget and gross sales in currency format (USD) rounded to the nearest
  whole dollar.

Order your results by the  average budget in descending order.
*/

SELECT genre,
COUNT(*) AS total_movies,
CONCAT("$", FORMAT(AVG(budget), 0)) AS avg_budget,
ROUND(AVG(runtime)) AS avg_runtime,
ROUND(AVG(score), 2) AS avg_score,
ROUND(AVG(CASE WHEN votes > 100000 THEN 1 ELSE 0 END) * 100) AS pct_votes_gt_100K,
CONCAT("$", FORMAT(MAX(gross), 0)) AS highest_gross
FROM boxofc
WHERE country = 'USA'
GROUP BY genre
HAVING COUNT(*) >= 100
ORDER BY avg_budget DESC;


/*
PUZZLE 3
Using the query from Puzzle #2 as a base for a dashboard, add a column with the
name of the movie with the max gross sales in the genre.
*/

-- Create a table for puzzle 2 query
CREATE TABLE IF NOT EXISTS movie_dashboard (
    SELECT genre,
    COUNT(*) AS total_movies,
    CONCAT("$", FORMAT(AVG(budget), 0)) AS avg_budget,
    ROUND(AVG(runtime)) AS avg_runtime,
    ROUND(AVG(score), 2) AS avg_score,
    ROUND(AVG(CASE WHEN votes > 100000 THEN 1 ELSE 0 END) * 100) AS pct_votes_gt_100K,
    CONCAT("$", FORMAT(MAX(gross), 0)) AS highest_gross
    FROM boxofc
    WHERE country = 'USA'
    GROUP BY genre
    HAVING COUNT(*) >= 100
    ORDER BY avg_budget DESC
);

-- Create a table for name of movie with highest gross
CREATE TABLE IF NOT EXISTS max_gross_movies (
    SELECT b.genre, b.name, m.highest_gross
    FROM boxofc b
    JOIN (
            SELECT m.genre, MAX(m.gross) AS highest_gross
            FROM boxofc m
            WHERE country = 'USA'
            GROUP BY genre
        ) m
    ON b.genre = m.genre AND b.gross = m.highest_gross
);

/*
-- Alternative for movie name with max genre gross
SELECT m.genre, m.name, m.gross
FROM boxofc m
LEFT JOIN boxofc b
    ON m.genre = b.genre AND m.gross < b.gross
WHERE b.gross is NULL
AND m.country = 'USA';
*/

-- Combo query
SELECT d.*, m.name as movie_max_gross
FROM movie_dashboard d
JOIN max_gross_movies m
ON d.genre = m.genre;


/*
PUZZLE 4

*/
