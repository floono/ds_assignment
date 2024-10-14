import mysql.connector

connection = mysql.connector.connect(
    user='me',
    password='myUserPassword',
    host='localhost',
    database='dswork'
)
cursor = connection.cursor()

# Change every gold medal row to a silver medal
update_stmt = 'UPDATE Medals SET medal_type = \'Silver Medal\' WHERE medal_type = \'Gold Medal\''
cursor.execute(update_stmt)
connection.commit()

cursor.close()
connection.close()