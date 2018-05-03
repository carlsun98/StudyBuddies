from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys
'''
Logout API @ /logout
Input:
    session token
Output:
    success/failure
'''

REQUIRED_KEYS = ["session_token"]

logout_api = Blueprint('logout_api', __name__)

@logout_api.route("/logout", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
def logout():
    cursor, conn = connect()
    token = request.form.get("session_token")
    logout_stmt = "DELETE FROM sessions where token=%s"
    cursor.execute(logout_stmt, (token,))
    if cursor.rowcount is not 1:
        return error_with_message("session_does_not_exist")

    conn.commit()
    return success_with_data({})