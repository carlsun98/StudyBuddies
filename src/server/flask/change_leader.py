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

change_leader_api = Blueprint('change_leader_api', __name__)

@change_leader_api.route("/change_leader", methods=['POST'])
def change_leader():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    new_leader_id = request.form.get("new_leader_id")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user_id = results[0][0]

    change_leader_stmt = "UPDATE groups SET leader_id=%d where leader_id=%d"
    cursor.execute(change_leader_stmt, (new_leader_id, user_id))

    if cursor.rowcount == 0:
        return error_with_message("user was not a group leader")

    conn.commit()
    return success_with_data({})