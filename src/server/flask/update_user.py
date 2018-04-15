from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
Update user API @ /update_user
Input:
    session_token
    push_notifications_enabled
    Apple_APN_Key
    Android_APN_Key
    group_id
    name
    class_year
Output:
    success/failure
'''

update_user_api = Blueprint('update_user_api', __name__)

@update_user_api.route("/update_user", methods=['POST'])
def update_user():
    cursor, conn = connect()
    session_token = request.form.get("session_token")

    choose_user_id_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(choose_user_id_stmt, (session_token,))
    user_id = cursor.fetchall()
    if len(user_id) == 0:
        return error_with_message("invalid_session_token")
    userID = user_id[0][0]

    check_user_id_stmt = "SELECT id FROM users WHERE id=%s"
    cursor.execute(check_user_id_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("user_does_not_exist")
    elif len(results) > 1:
        return error_with_message("more_than_one_user")

    choose_defaults_stmt = "SELECT push_notifications_enabled, Apple_APN_Key, Android_APN_Key, group_id, name, class_year FROM users WHERE id=%s"
    cursor.execute(choose_defaults_stmt, (userID,))
    default_push = cursor.fetchone()[0]
    default_apple = cursor.fetchone()[1]
    default_android = cursor.fetchone()[2]
    default_group_id = cursor.fetchone()[3]
    default_name = cursor.fetchone()[4]
    default_class_year = cursor.fetchone()[5]

    push_notif_enable = request.form.get("push_notifications_enabled", default_push)
    Apple_APN_Key = request.form.get("Apple_APN_Key", default_apple)
    Android_APN_Key = request.form.get("Android_APN_Key", default_android)
    group_id = request.form.get("group_id", default_group_id)
    name = request.form.get("name", default_name)
    class_year = request.form.get("class_year", default_class_year)

    update_user_stmt = "UPDATE users SET push_notifications_enabled=%s, Apple_APN_Key=%s, Android_APN_Key=%s, group_id=%s, name=%s, class_year=%s WHERE id=%s"
    cursor.execute(update_user_stmt, (push_notif_enable, Apple_APN_Key, Android_APN_Key, group_id, name, class_year, userID))
    if cursor.rowcount is not 1:
        return error_with_message("updating user failed")

    conn.commit()
    return success_with_data({})
