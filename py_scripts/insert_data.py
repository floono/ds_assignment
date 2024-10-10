import mysql.connector
import csv

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor('INSERT INTO Countries (country_code, country_name) VALUES (a, b);')

cursor.execute()

# Function to read by row and insert data
def insertFunc(csv_path, insert_stmt):
    with open(csv_path, mode='r') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)
        for row in reader:
            for string in row:
                if string == '':
                    string = None
            cursor.execute(insert_stmt, row)
    connection.commit()

# Countries Table (countries.csv)
insertFunc('archive/countries.csv', 'INSERT INTO Countries (country_code, country_name) VALUES (%s, %s);')

cursor.close()
connection.close()