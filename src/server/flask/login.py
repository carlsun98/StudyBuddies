from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from verify import verify_required_keys

'''
Login API @ /login
Input:
    email
    password
Output:
    session token
'''

REQUIRED_KEYS = ["email", "password"]

login_api = Blueprint('login_api', __name__)

@login_api.route("/login", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
def login():
    cursor, conn = connect()
    email = request.form.get("email")
    passwd = request.form.get("password")

    login_stmt = "SELECT id, email, name, class_year, salt, password, account_confirmed FROM users WHERE email=%s"
    cursor.execute(login_stmt, (email,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("account_not_created")
    if results[0][6] == 0:
        return error_with_message("email_not_confirmed")
    salted_password = passwd + results[0][4]
    if not bcrypt_sha256.verify(salted_password, results[0][5]):
        return error_with_message("bad_login")
    user = results[0]
    user_id = user[0]

    delete_duplicates_stmt = "DELETE FROM sessions WHERE user_id=%s"
    cursor.execute(delete_duplicates_stmt, (user_id,))

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
            "email": user[1],
            "name": user[2],
            "class_year": user[3]
        }
    })
