from flask import Flask, g, jsonify, request
from mysql import connector
import random, string

app = Flask(__name__)

# database conn setup
def connect():
    conn = connector.connect(user = 'root',
                             password = 'lumbroso',
                             host='127.0.0.1',
                             database='studybuddies')
    c = conn.cursor()
    return c, conn

def success_with_data(data):
    response = [{"success" : 1, "message" : ""}, data]
    return jsonify(response)

def error_with_message(message):
    response = [{"success" : 0, "message" : message}]
    return jsonify(response)

# test
@app.route('/')
def index():
    return 'Hello, World!'

@app.route('/login', methods=['POST'])
def login():
    cursor, conn = connect()
    email = request.form.get("email")
    passwd = request.form.get("password")
    login_stmt = "SELECT id FROM users WHERE email=%s AND password=%s"
    cursor.execute(login_stmt, (email, passwd))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_login")

    user = results[0]
    user_id = user[0]

    session_token = ''.join(random.choice(string.ascii_letters +
                                          string.digits) for _ in range(32))
    session_create_stmt = "INSERT INTO sessions (user_id, token) VALUES (%s, %s)"
    cursor.execute(session_create_stmt, (user_id, session_token))
    if cursor.rowcount is not 1:
        return error_with_message("session creation failed")
    conn.commit()
    return success_with_data({"token": session_token})

@app.route('/create_user', methods=['POST'])
def create_user():
    cursor, conn = connect()
    email = request.form.get("email")
    passwd = request.form.get("password")
    name = request.form.get("name", "NO_NAME")
    class_year = request.form.get("class_year", "0000")
    
    check_existing_users_stmt = "SELECT COUNT(*) FROM users WHERE email=%s"
    cursor.execute(check_existing_users_stmt, (email))
    count = cursor.fetchone()[0]
    if count is not 0:
        return error_with_message("user already exists")
    
    create_user_stmt = "INSERT INTO users (email, password, name, class_year) VALUES (%s %s %s %s)"
    cursor.execute(create_user_stmt, (email, password, name, class_year))
    if cursor.rowcount is not 1:
        return error_with_message("creating user failed")
    conn.commit()
    return success_with_data({})

@app.route('/sqltest')
def sqltest():
    return "Hi Malika!"

if __name__ == '__main__':
    app.run(host='0.0.0.0')
