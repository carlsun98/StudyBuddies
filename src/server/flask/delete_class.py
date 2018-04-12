from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys
'''
Delete Class API @ /delete_class
Input:
    session token
    class id
Output:
    success/failure
    deleted class id
'''

REQUIRED_KEYS = ["session_token", "class_id"]

delete_class_api = Blueprint('delete_class_api', __name__)

@delete_class_api.route("/delete_class", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def delete_class(**kwargs):
    user_id = kwargs["user_id"]
    class_id = request.form.get("class_id")
    del_class_stmt = "DELETE FROM user_classes where user_id=%s, class_id=%s"
    cursor.execute(del_class_stmt, (user_id, class_id))
    if cursor.rowcount is not 1:
        return error_with_message("msg_failed_to_delete_class_for_user")

    conn.commit()
    return success_with_data({"deleted_class_id": class_id})
