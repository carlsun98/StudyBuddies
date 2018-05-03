from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required

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
@auth_required
def update_user(**kwargs):
    cursor, conn = connect()
    userID = kwargs["user_id"]

    check_user_id_stmt = "SELECT id FROM users WHERE id=%s"
    cursor.execute(check_user_id_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("user_does_not_exist")
    elif len(results) > 1:
        return error_with_message("more_than_one_user")

    check_password_stmt = "SELECT id FROM users WHERE id=%s AND password=%s"
    cursor.execute(check_user_id_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("incorrect password")

    choose_defaults_stmt = "SELECT push_notifications_enabled, Apple_APN_Key, Android_APN_Key, group_id, name, class_year, password FROM users WHERE id=%s"
    cursor.execute(choose_defaults_stmt, (userID,))
    result = cursor.fetchone()
    default_push = result[0]
    default_apple = result[1]
    default_android = result[2]
    default_group_id = result[3]
    default_name = result[4]
    default_class_year = result[5]
    default_password = result[6]

    push_notif_enable = request.form.get("push_notifications_enabled", default_push)
    Apple_APN_Key = request.form.get("Apple_APN_Key", default_apple)
    Android_APN_Key = request.form.get("Android_APN_Key", default_android)
    group_id = request.form.get("group_id", default_group_id)
    name = request.form.get("name", default_name)
    class_year = request.form.get("class_year", default_class_year)
    password = request.form.get("password", default_password)
    if int(push_notif_enable) != 0 and int(push_notif_enable) != 1:
        return error_with_message("Push notifications is not 0 or 1.")
    if int(group_id) < -1:
        return error_with_message("Group id too negative")

    update_user_stmt = "UPDATE users SET push_notifications_enabled=%s, Apple_APN_Key=%s, Android_APN_Key=%s, group_id=%s, name=%s, class_year=%s, password=%s WHERE id=%s"
    cursor.execute(update_user_stmt, (push_notif_enable, Apple_APN_Key, Android_APN_Key, group_id, name, class_year, password, userID))
    if cursor.rowcount is not 1:
        return error_with_message("updating user failed")

    conn.commit()
    return success_with_data({})
