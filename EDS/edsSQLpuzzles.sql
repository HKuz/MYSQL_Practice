# Puzzle 1

SELECT genre, COUNT(*) AS total_movies,
AVG(budget) as avg_budget,
AVG(runtime) as avg_runtime,
AVG(score) as avg_score,
AVG(CASE WHEN votes > 100000 THEN 1 ELSE 0 END) * 100 AS pct_votes_gt_100K
FROM boxofc
WHERE country = 'USA'
GROUP BY genre
ORDER BY total_movies DESC;

# Puzzle 2
