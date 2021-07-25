/*
Database: edsSQLChalls
Dataset: foot-moneyball

PUZZLE 7
Write a query that:

- Calculates the average score allowed by a "team" to "opponents" in 2012, in
their home stadium (location = 'H')
- Calculates the average score allowed by an "opponent" to "teams" in 2012, in
their home stadium (location = 'A')
- Selects any teams for which the above calculations do not match.

Tip: Remember to account for the possibility of multiple quarterbacks on a team
playing in a game.
*/

SELECT
    t_home.*,
    o_away.avg_team_score
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
