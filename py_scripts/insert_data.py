import mysql.connector
import csv
import datetime
import re

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor('INSERT INTO Countries (country_code, country_name) VALUES (a, b);')

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
                    row[i] = datetime.strptime(row[i], "%Y-%m-%d %H:%M%S")
            cursor.execute(insert_stmt, row)
    connection.commit()

# Countries Table (countries.csv)
insertFunc('data/countries.csv', 'INSERT INTO Countries (country_code, country_name) VALUES (%s, %s);')

# Teams Table
insertFunc('data/teams.csv', 'INSERT INTO Teams (team_code, team_name, team_gender) VALUES (%s, %s, %s);')

# Events Table
insertFunc('data/events.csv', 'INSERT INTO Events (stage_code, discipline_name, event_name, event_datetime, stage, venue_name) VALUES (%s, %s, %s, %s, %s, %s);')

# Athletes Table
insertFunc('data/athletes.csv', 'INSERT INTO Athletes (athlete_code, athlete_name, athlete_gender, country_code, athlete_height, athlete_birth_date, team_code) VALUES (%s, %s, %s, %s, %s, %s, %s);')

# Medals Table
insertFunc('data/medals.csv', 'INSERT INTO Medals (medal_date, medal_type, athlete_code) VALUES (%s, %s, %s);')

# TeamParticipants Table
insertFunc('data/team_participants.csv', 'INSERT INTO TeamParticipants (team_code, stage_code, result_rank, result, result_type) VALUES (%s, %s, %s, %s, %s);')

# IndividualParticipants Table
insertFunc('data/individual_participants.csv', 'INSERT INTO IndividualParticipants (athlete_code, stage_code, result_rank, result, result_type) VALUES (%s, %s, %s, %s, %s);')

cursor.close()
connection.close()