from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys
'''
Delete User API @ /delete_user
Input:
    session token
Output:
    success/failure
'''
REQUIRED_KEYS = ["session_token", "password"]

delete_user_api = Blueprint('delete_user_api', __name__)

@delete_user_api.route("/delete_user", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def delete_user(**kwargs):
    cursor, conn = connect()
    password = request.form.get("password")
    user_id = kwargs["user_id"]

    del_user_stmt = "DELETE from users where id=%s AND password=%s"
    cursor.execute(del_user_stmt, (user_id, password))
    if cursor.rowcount is not 1:
        return error_with_message("user does not exist")

    del_user_class_stmt = "DELETE from user_classes where user_id=%s"
    cursor.execute(del_user_class_stmt, (user_id,))

    del_user_sess_stmt = "DELETE from sessions where user_id=%s"
    cursor.execute(del_user_sess_stmt, (user_id,))

    find_group_stmt = "SELECT id FROM groups WHERE leader_id=%s"
    cursor.execute(find_group_stmt, (user_id,))
    results = cursor.fetchall()
    if len(results) != 0:
        group_id = results[0][0]
        find_member_stmt = "SELECT id FROM users WHERE group_id=%s"
        cursor.execute(find_member_stmt, (group_id,))
        results = cursor.fetchall()
        if len(results) == 0:
            del_group_stmt = "DELETE from groups where leader_id=%s"
            cursor.execute(del_group_stmt, (user_id,))
        else:
            newlead = results[0][0]
            change_leader_stmt = "UPDATE groups SET leader_id=%s where leader_id=%s"
            cursor.execute(change_leader_stmt, (newlead, user_id))

    conn.commit()
    return success_with_data({})
