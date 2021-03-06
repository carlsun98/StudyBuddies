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
    cursor, conn = connect()
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

    if leader_id == user_id:
        find_members_stmt = "SELECT id FROM users WHERE group_id=%s"
        cursor.execute(find_members_stmt, (group_id,))
        results = cursor.fetchall()
        if len(results) != 0:
            new_leader_id = results[0][0]
            change_leader_stmt = "UPDATE groups SET leader_id=%s WHERE id=%s"
            cursor.execute(change_leader_stmt, (new_leader_id, group_id))
        else:
            del_group_stmt = "DELETE FROM groups WHERE id=%s"
            cursor.execute(del_group_stmt, (group_id))

    leave_group_stmt = "UPDATE users SET group_id=-1 WHERE id=%s"
    cursor.execute(leave_group_stmt, (user_id,))
    count_stmt = "SELECT COUNT(*) FROM users WHERE group_id=%s"
    cursor.execute(count_stmt, (group_id,))
    count = cursor.fetchone()[0]

    if count == 0:
        delete_group_stmt = "DELETE FROM groups WHERE id=%s"
        cursor.execute(delete_group_stmt, (group_id,))

    conn.commit()
    return success_with_data({})
