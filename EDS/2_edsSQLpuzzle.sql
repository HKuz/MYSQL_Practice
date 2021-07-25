/*
Database: edsSQLChalls
Dataset: box office

PUZZLE 2
Produce the same table from Puzzle #1, with the following changes:

- Remove genres with under 100 movies released
- Round average runtime to the nearest integer
- Round average score to two decimal places
- Round percent of movies with 100K votes to the nearest percentage point
- Add the gross sales value from the movie with the highest gross sales
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
