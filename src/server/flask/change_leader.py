from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
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

REQUIRED_KEYS = ["session_token", "new_leader_id"]

change_leader_api = Blueprint('change_leader_api', __name__)

@change_leader_api.route("/change_leader", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def change_leader(**kwargs):
    cursor, conn = connect()
    new_leader_id = request.form.get("new_leader_id")
    user_id = kwargs["user_id"]

    change_leader_stmt = "UPDATE groups SET leader_id=%d where leader_id=%d"
    cursor.execute(change_leader_stmt, (new_leader_id, user_id))

    if cursor.rowcount == 0:
        return error_with_message("user was not a group leader")

    conn.commit()
    return success_with_data({})
