# Updates the number of medals a country has one everytime an entry is added to the Medals table
DELIMITER //
CREATE TRIGGER UpdateMedals AFTER INSERT ON Medals
    FOR EACH ROW
        BEGIN
            # Finding the country code of the athlete that won the medal
            DECLARE medal_country_code CHAR(3);
            SELECT country_code INTO medal_country_code FROM Athletes WHERE athlete_code = NEW.athlete_code;

            IF NEW.medal_type = 'Gold Medal' THEN
                UPDATE Countries SET gold_count = gold_count + 1 WHERE country_code = medal_country_code;
            ELSEIF NEW.medal_type = 'Silver Medal' THEN
                UPDATE Countries SET silver_count = silver_count + 1 WHERE country_code = medal_country_code;
            ELSEIF NEW.medal_type = 'Bronze Medal' THEN
                UPDATE Countries SET bronze_count = bronze_count + 1 WHERE country_code = medal_country_code;
            END IF;
        END//
DELIMITER ;