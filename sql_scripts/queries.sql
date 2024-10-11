# Query to find all athletes that achieved a gold medal
SELECT athlete_code, athlete_name, country_code FROM Athletes
JOIN Medals ON Athletes.athlete_code = Medals.athlete_code
WHERE Medals.medal_type = 'Gold Medal';

# Query to list countries in descending order of medals achieved (with priorities)
SELECT country_code, country_name, gold_count, silver_count, bronze_count, (gold_count + silver_count+ bronze_count) AS medal_count FROM Countries
ORDER BY medal_count DESC, gold_count DESC, silver_count DESC, bronze_count DESC;