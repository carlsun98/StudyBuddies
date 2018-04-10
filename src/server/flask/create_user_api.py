from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
Create user API @ /create_user
Input:
    email
    password
    name
    class_year
Output:
    none
'''

create_user_api = Blueprint('create_user_api', __name__)

@create_user_api.route('/create_user', methods=['POST'])
def create_user():
    cursor, conn = connect()
    email = request.form.get("email")
    passwd = request.form.get("password")
    name = request.form.get("name", "NO_NAME")
    class_year = request.form.get("class_year", "0000")
    
    check_existing_users_stmt = "SELECT COUNT(*) FROM users WHERE email=%s"
    cursor.execute(check_existing_users_stmt, (email,))
    count = cursor.fetchone()[0]
    if count is not 0:
        return error_with_message("user already exists")
    
    create_user_stmt = "INSERT INTO users (email, password, name, class_year) VALUES (%s %s %s %s)"
    cursor.execute(create_user_stmt, (email, password, name, class_year))
    if cursor.rowcount is not 1:
        return error_with_message("creating user failed")

    user_id = cursor.lastrowid
    confirmation_token = ''.join(random.choice(string.ascii_letters +
                                          string.digits) for _ in range(32))
    create_confirmation_stmt = "INSERT INTO email_confirmations (user_id, token) VALUES (%d %s)"
    cursor.execute(create_confirmation_stmt, (user_id, confirmation_token))
    conn.commit()
    return success_with_data({"confirmation_token" : confirmation_token})