# Basic select query to determine what athletes have a gold medal
SELECT athlete_code, athlete_name, country_code FROM Athletes
JOIN Medals ON Athletes.athlete_code = Medals.athlete_code
WHERE Medals.medal_type = 'Gold Medal';