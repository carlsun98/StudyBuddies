from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required

'''
Leave Group API @ /leave_group
Input:
    session token
Output:
    success/failure
'''

leave_group_api = Blueprint('leave_group_api', __name__)

@leave_group_api.route("/leave_group", methods=['POST'])
@auth_required
def leave_group(**kwargs):
    user_id = kwargs["user_id"]

    get_group_stmt = "SELECT group_id FROM users WHERE id=%s"
    cursor.execute(get_group_stmt, (user_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("msg_user_does_not_exist")
    group_id = results[0][0]

    get_leader_stmt = "SELECT leader_id FROM groups WHERE id=%s"
    cursor.execute(get_leader_stmt, (group_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("msg_group_does_not_exist")

    leader_id = results[0][0]

    if results[0][0] == user_id:
        find_members_stmt = "SELECT id FROM users WHERE group_id=%s"
        cursor.execute(find_members_stmt, (group_id))
        results = cursor.fetchall()
        if len(results) != 0:
            newlead = results[0][0]
            change_leader_stmt = "UPDATE groups SET leader_id=%d where leader_id=%s"
            cursor.execute(change_leader_stmt, (newlead, user))
        else:
            del_group_stmt = "DELETE from groups where leader_id=%s"
            cursor.execute(del_group_stmt, (user_id))

    leave_group_stmt = "UPDATE users SET group=-1 where id=%s"
    cursore.execute(leave_group_stmt, (usere_id))

    conn.commit()
    return success_with_data({})
