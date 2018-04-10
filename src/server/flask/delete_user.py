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

delete_user_api = Blueprint('delete_user_api', __name__)

@delete_user_api.route("/delete_user", methods=['POST'])
def delete_user():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user = results[0][0]

    del_user_stmt = "DELETE from users where user_id=%d"
    cursor.execute(del_user_stmt, (user))
    if cursor.rowcount is not 1:
        return error_with_message("user does not exist")

    del_user_class_stmt = "DELETE from user_classes where user_id=%d"
    cursor.execute(del_user_stmt, (user))

    del_user_sess_stmt = "DELETE from sessions where user_id=%d"
    cursor.execute(del_user_sess_stmt, (user))

    find_group_stmt = "SELECT id FROM groups WHERE leader_id=%d"
    cursor.execute(find_group_stmt, (user))
    results = cursor.fetchall()
    if len(results) != 0:
        group_id = results[0][0]
        find_member_stmt = "SELECT id FROM users WHERE group_id=%d"
        cursor.execute(find_member_stmt, (group_id))
        results = cursor.fetchall
        if len(results) == 0:
            del_group_stmt = "DELETE from groups where leader_id=%d"
            cursor.execute(del_group_stmt, (user))
        else:
            newlead = results[0][0]
            change_leader_stmt = "UPDATE groups SET leader_id=%d where leader_id=%d"
            cursor.execute(change_leader_stmt, (newlead, user))

    conn.commit()
    return success_with_data({})