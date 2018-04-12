from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys

'''
Login API @ /login
Input:
    email
    password
Output:
    session token
'''

REQUIRED_KEYS = ["session_token"]

delete_group_api = Blueprint('delete_group_api', __name__)

@delete_group_api.route("/delete_group", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def delete_group(**kwargs):
    user_id = kwargs["user_id"]

    get_group_stmt = "SELECT id FROM groups WHERE leader_id=%s"
    cursor.execute(get_group_stmt, (user_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("msg_user_not_leader_of_group")
    group_id = results[0][0]

    del_group_stmt = "DELETE FROM groups WHERE leader_id=%s"
    cursor.execute(del_group_stmt, (user_id,))
    if cursor.rowcount is not 1:
        return error_with_message("msg_failed_to_delete_class")

    leave_group_stmt = "UPDATE users SET group=-1 where group_id=%s"
    cursore.execute(leave_group_stmt, (group_id,)

    conn.commit()
    return success_with_data({})
