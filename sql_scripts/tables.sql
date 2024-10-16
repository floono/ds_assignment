CREATE TABLE Countries(
    country_code CHAR(3),
    country_name VARCHAR(100) NOT NULL,
    gold_count INT DEFAULT 0,
    silver_count INT DEFAULT 0,
    bronze_count INT DEFAULT 0,
    PRIMARY KEY (country_code)
);

CREATE TABLE Teams(
    team_code CHAR(17),
    team_name VARCHAR(100) NOT NULL,
    team_gender CHAR(1) CHECK (team_gender = 'M' OR team_gender = 'W' OR team_gender = 'O' OR team_gender = 'X'),
    PRIMARY KEY (team_code)
);

CREATE TABLE Events(
    stage_code CHAR(34),
    discipline_name VARCHAR(100) NOT NULL,
    event_name VARCHAR(100) NOT NULL,
    event_datetime DATETIME,
    stage VARCHAR(100),
    venue_name VARCHAR(100),
    PRIMARY KEY (stage_code)
);

CREATE TABLE Athletes(
    athlete_code CHAR(7),
    athlete_name VARCHAR(100) NOT NULL,
    athlete_gender CHAR(1) CHECK (athlete_gender = 'M' OR athlete_gender = 'F'),
    country_code CHAR(3) NOT NULL,
    athlete_height INT,
    athlete_birth_date DATE,
    team_code CHAR(17),
    PRIMARY KEY (athlete_code),
    FOREIGN KEY (country_code) REFERENCES Countries(country_code) ON DELETE CASCADE,
    FOREIGN KEY (team_code) REFERENCES Teams(team_code)
);

CREATE TABLE Medals(
    medal_id INT AUTO_INCREMENT,
    medal_date DATE,
    medal_type VARCHAR(50),
    athlete_code CHAR(7) NOT NULL,
    PRIMARY KEY (medal_id),
    FOREIGN KEY (athlete_code) REFERENCES Athletes(athlete_code) ON DELETE CASCADE
);

CREATE TABLE TeamParticipants(
    team_code CHAR(17),
    stage_code CHAR(34),
    result_rank INT,
    result VARCHAR(50),
    result_type VARCHAR(50),
    FOREIGN KEY (team_code) REFERENCES Teams(team_code) ON DELETE CASCADE,
    FOREIGN KEY (stage_code) REFERENCES Events(stage_code) ON DELETE CASCADE,
    PRIMARY KEY (stage_code, team_code)
);

CREATE TABLE IndividualParticipants(
    athlete_code CHAR(7),
    stage_code CHAR(34),
    result_rank INT,
    result VARCHAR(50),
    result_type VARCHAR(50),
    FOREIGN KEY (athlete_code) REFERENCES Athletes(athlete_code) ON DELETE CASCADE,
    FOREIGN KEY (stage_code) REFERENCES Events(stage_code) ON DELETE CASCADE,
    PRIMARY KEY (stage_code, athlete_code)
);