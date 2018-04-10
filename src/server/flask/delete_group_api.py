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

delete_group_api = Blueprint('delete_group_api', __name__)

@delete_group_api.route("/delete_group", methods=['POST'])
def delete_group():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user_id = results[0][0]

    get_group_stmt = "SELECT id FROM groups WHERE leader_id=%d"
    cursor.execute(get_group_stmt, (user_id))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("user is not leader of a group")
    group_id = results[0][0]

    del_group_stmt = "DELETE from groups where leader_id=%d"
    cursor.execute(del_group_stmt, (user_id))
    if cursor.rowcount is not 1:
        return error_with_message("failed to delete class")

    leave_group_stmt = "UPDATE users SET group=-1 where group_id=%d"
    cursore.execute(leave_group_stmt, (group_id))

    conn.commit()
    return success_with_data({})