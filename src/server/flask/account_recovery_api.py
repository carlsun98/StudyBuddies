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

account_recovery_api = Blueprint('account_recovery_api', __name__)

@account_recovery_api.route("/account_recovery", methods=['POST'])
def account_recovery():
    cursor, conn = connect()
    recovery_token = request.form.get("recovery_token")
    new_password = request.form.get("new_password")

    find_token_stmt = "SELECT user_id FROM password_recovery WHERE token=%s"
    cursor.execute(find_token_stmt, (recovery_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_recovery_code")

    user_id = results[0][0]

    change_password_stmt = "UPDATE users SET password=%s where id=%d"
    cursor.execute(change_password_stmt, (new_password, user_id))

    if cursor.rowcount == 0:
        return error_with_message("user does not exist")

    conn.commit()
    return success_with_data({})