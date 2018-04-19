from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required

'''
Join Group API @ /join_group
Input:
    session_token
    group_id
Output:
    success/failure
'''

join_group_api = Blueprint('join_group_api', __name__)

@join_group_api.route("/join_group", methods=['POST'])
@auth_required
def join_group(**kwargs):
    cursor, conn = connect()
    user_id = kwargs["user_id"]
    group_id = request.form.get("group_id")
    check_group_id_stmt = "SELECT COUNT(*) FROM groups WHERE id=%s"
    cursor.execute(check_group_id_stmt, (group_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("no_matching_group_id")
    update_stmt = "UPDATE users SET group_id=%s WHERE id=%s"
    cursor.execute(update_stmt, (group_id, user_id))

    conn.commit()
    return success_with_data({})
