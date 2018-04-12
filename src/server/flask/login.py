from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
Login API @ /login
Input:
    email
    password
Output:
    session token
'''

login_api = Blueprint('login_api', __name__)

@login_api.route("/login", methods=['POST'])
def login():
    cursor, conn = connect()
    email = request.form.get("email")
    passwd = request.form.get("password")
    login_stmt = "SELECT id, email, name, class_year FROM users WHERE email=%s AND password=%s"
    cursor.execute(login_stmt, (email, passwd))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("bad_login")

    user = results[0]
    user_id = user[0]

    session_token = ''.join(random.choice(string.ascii_letters +
                                          string.digits) for _ in range(32))
    session_create_stmt = "INSERT INTO sessions (user_id, token) VALUES (%s, %s)"
    cursor.execute(session_create_stmt, (user_id, session_token))
    if cursor.rowcount is not 1:
        return error_with_message("bad_session_creation")
    conn.commit()
    return success_with_data({
        "token": session_token,
        "user_info": {
            "id": user_id,
            "email": results[1],
            "name": results[2],
            "class_year": results[3]
        }
    })
