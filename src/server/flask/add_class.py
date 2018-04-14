from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys

'''Add class API @ /add_class
Input:
    class_id
    session_token
Output:
    success/failure
'''

add_class_api = Blueprint('add_class_api', __name__)

@add_class_api.route("/add_class", methods=['POST'])
def add_class():
    cursor, conn = connect()
    class_id = (request.form.get("class_id"))
    session_token = request.form.get("session_token")

    #Check: Check if entered class id exists
    check_class_stmt = "SELECT COUNT(*) FROM classes WHERE id=%d"
    cursor.execute(check_class_stmt, (class_id,))
    count = cursor.fetchone()[0]
    if count is 0:
        return error_with_message("invalid_class_id")
    elif count is not 1:
        return error_with_message("multiple_class_id (This message should not pop up)")

    # Choose the id associated with the session token
    choose_user_id_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(choose_user_id_stmt, (session_token))
    user_id = cursor.fetchall()
    if len(user_id) == 0:
        return error_with_message("invalid_session_token")
    userID = user_id[0][0]

    # Check: Check if this user already has the class added
    check_class_list_stmt = "SELECT COUNT(*) FROM user_classes WHERE user_id=%d AND class_id=%d"
    cursor.execute(check_class_list_stmt, (userID, class_id))
    count = cursor.fetchall()
    if len(count) != 0:
        return error_with_message("user_has_this_class")

    # Add class to user's classes
    add_class_stmt = "INSERT INTO user_classes (user_id, class_id) VALUES (%d %d)"
    cursor.execute(add_class_stmt, (userID, class_id))
    if cursor.rowcount is not 1:
        return error_with_message("adding class failed")

    conn.commit()
    return success_with_data({})
