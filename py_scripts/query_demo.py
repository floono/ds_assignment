import mysql.connector

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor()

# Get all athletes with height greater than 180cm then print
query_stmt = 'SELECT * FROM Athletes WHERE athlete_height > 180'
cursor.execute(query_stmt)
row = cursor.fetchone()
while row is not None:
    print(row)
    row = cursor.fetchone()

cursor.close()
connection.close()