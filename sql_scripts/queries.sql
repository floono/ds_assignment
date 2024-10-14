# Query to find all athletes that achieved a gold medal
SELECT Athletes.athlete_code, athlete_name, country_code FROM Athletes
JOIN Medals ON Athletes.athlete_code = Medals.athlete_code
WHERE Medals.medal_type = 'Gold Medal';

# Query to find all athletes that didn't win any medals
SELECT athlete_code, athlete_name, country_code FROM Athletes
WHERE athlete_code NOT IN (SELECT athlete_code FROM Medals)
ORDER BY country_code;

# Query to list countries in descending order of medals achieved (with priorities)
SELECT country_code, country_name, gold_count, silver_count, bronze_count, (gold_count + silver_count + bronze_count) AS medal_count FROM Countries
ORDER BY medal_count DESC, gold_count DESC, silver_count DESC, bronze_count DESC;

# Query to get the results of all athletes that competed in Men's 800m Final in ascending order
SELECT Athletes.athlete_code, athlete_name, result_rank, result, result_type FROM Athletes
JOIN IndividualParticipants ON Athletes.athlete_code = IndividualParticipants.athlete_code
WHERE stage_code = 'ATHM800M--------------FNL-000100--'
ORDER BY result_rank ASC;

# Query to get the average height of all athletes (grouped by gender)
SELECT athlete_gender, AVG(athlete_height) as avg_height
FROM Athletes
GROUP BY athlete_gender;

# Query to get all athletes below age 25 that achieved a gold medal in ascending order of age
SELECT athlete_code, athlete_name, country_code, athlete_age, athlete_birth_date
FROM 
(
    SELECT Athletes.athlete_code, athlete_name, country_code, FLOOR(DATEDIFF('2024-08-11', athlete_birth_date) / 365) AS athlete_age, athlete_birth_date FROM Athletes
    JOIN Medals ON Athletes.athlete_code = Medals.athlete_code
    WHERE Medals.medal_type = 'Gold Medal'
) AS gold_medallists
WHERE athlete_age < 25
GROUP BY athlete_code # this prevents duplicates as athletes can win multiple medals
ORDER BY athlete_age ASC;

# Query to get the number of athletes from each country
SELECT Countries.country_code, Countries.country_name, COUNT(athlete_code) AS athlete_count
FROM Athletes
JOIN Countries ON Athletes.country_code = Countries.country_code
GROUP BY Countries.country_code
ORDER BY athlete_count DESC;