CREATE PROCEDURE insertMedal(
    temp_medal_date DATE,
    temp_medal_type VARCHAR(50),
    temp_athlete_code CHAR(7)
)
COMMENT 'Insert new medal into the Medals table.'
INSERT INTO Medals(medal_date, medal_type, athlete_code)
VALUES (temp_medal_date, temp_medal_type, temp_athlete_code);

# To use:
# CALL insertMedal(date, type, code)