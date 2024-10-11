import mysql.connector
import csv
from datetime import datetime
from datetime import date
import re

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor()

cursor.execute('SOURCE sql_scripts/tables.sql;')

# Function to read by row and insert data
def insertFunc(csv_path, insert_stmt):
    with open(csv_path, mode='r') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)
        for row in reader:
            for i in range(len(row)):
                if(row[i] == ''): # NULL entries
                    row[i] = None
                elif re.match(r"^\d{4}-\d{2}-\d{2}$", row[i]): # Date entries
                    row[i] = datetime.strptime(row[i], "%Y-%m-%d").date()
                elif re.match(r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$", row[i]): # Datetime entries
                    row[i] = datetime.strptime(row[i], "%Y-%m-%d %H:%M:%S")
            cursor.execute(insert_stmt, row)
    connection.commit()

## Inserting data in specific order to allow foreign keys to work correctly ##
# Countries Table (countries.csv)
insertFunc('data/countries.csv', 'INSERT INTO Countries (country_code, country_name) VALUES (%s, %s);')

# Teams Table (teams.csv)
insertFunc('data/teams.csv', 'INSERT INTO Teams (team_code, team_name, team_gender) VALUES (%s, %s, %s);')

# Events Table (events.csv)
insertFunc('data/events.csv', 'INSERT INTO Events (stage_code, discipline_name, event_name, event_datetime, stage, venue_name) VALUES (%s, %s, %s, %s, %s, %s);')

# Athletes Tables (athletes.csv)
insertFunc('data/athletes.csv', 'INSERT INTO Athletes (athlete_code, athlete_name, athlete_gender, country_code, athlete_height, athlete_birth_date, team_code) VALUES (%s, %s, %s, %s, %s, %s, %s);')

# Medals Table (medals.csv)
insertFunc('data/medals.csv', 'INSERT INTO Medals (medal_date, medal_type, athlete_code) VALUES (%s, %s, %s);')

# TeamParticipants Table (team_participants.csv)
insertFunc('data/team_participants.csv', 'INSERT INTO TeamParticipants (team_code, stage_code, result_rank, result, result_type) VALUES (%s, %s, %s, %s, %s);')

# IndividualParticipants Table (individual_participants.csv)
insertFunc('data/individual_participants.csv', 'INSERT INTO IndividualParticipants (athlete_code, stage_code, result_rank, result, result_type) VALUES (%s, %s, %s, %s, %s);')

cursor.close()
connection.close()