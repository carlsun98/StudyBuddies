from mysql import connector

# Database connection. Please keep these parameters secret.
def connect():
    conn = connector.connect(user = 'root',
                             password = 'lumbroso',
                             host='127.0.0.1',
                             database='studybuddies')
    c = conn.cursor()
    return c, conn