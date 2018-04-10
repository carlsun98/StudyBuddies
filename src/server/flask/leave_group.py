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

leave_group_api = Blueprint('leave_group_api', __name__)

@leave_group_api.route("/leave_group", methods=['POST'])
def leave_group():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user_id = results[0][0]

    get_group_stmt = "SELECT group_id FROM users WHERE id=%d"
    cursor.execute(get_group_stmt, (user_id))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("user does not exist")
    group_id = results[0][0]

    get_leader_stmt = "SELECT leader_id FROM groups WHERE id=%d"
    cursor.execute(get_leader_stmt, (group_id))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("group does not exist")

    leader_id = results[0][0]

    if results[0][0] == user_id:
        find_members_stmt = "SELECT id FROM users WHERE group_id=%d"
        cursor.execute(find_members_stmt, (group_id))
        results = cursor.fetchall()
        if len(results) != 0:
            newlead = results[0][0]
            change_leader_stmt = "UPDATE groups SET leader_id=%d where leader_id=%d"
            cursor.execute(change_leader_stmt, (newlead, user))
        else:
            del_group_stmt = "DELETE from groups where leader_id=%d"
            cursor.execute(del_group_stmt, (user_id))

    leave_group_stmt = "UPDATE users SET group=-1 where id=%d"
    cursore.execute(leave_group_stmt, (usere_id))

    conn.commit()
    return success_with_data({})