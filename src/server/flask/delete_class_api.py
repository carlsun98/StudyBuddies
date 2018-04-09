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

delete_class_api = Blueprint('delete_class_api', __name__)

@delete_class_api.route("/delete_class", methods=['POST'])
def delete_class():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    class_id = request.form.get("class_id")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user_id = results[0][0]

    del_class_stmt = "DELETE from user_classes where user_id=%d, class_id=%d"
    cursor.execute(del_class_stmt, (user_id, class_id))
    if cursor.rowcount is not 1:
        return error_with_message("user does not match with class")

    conn.commit()
    return success_with_data({})
