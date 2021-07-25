/*
Database: edsSQLChalls
Dataset: box office

PUZZLE 1
We are interested in some basic statistics for movies released in the US only,
segmented by genre.

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
