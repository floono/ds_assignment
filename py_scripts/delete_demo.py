import mysql.connector

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor()

# Delete every bronze medal row
delete_stmt = 'DELETE FROM Medals WHERE medal_type = \'Bronze Medal\''
cursor.execute(delete_stmt)
connection.commit()

cursor.close()
connection.close()