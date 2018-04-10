from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
Create group API @ /create_group
Input:
    class_id
    session_token
    end_time
    category
    description
    location_lat
    location_lon
    location_description
Output:
    success/failure
'''

create_group_api = Blueprint('create_group_api', __name__)

@create_group_api.route("/create_group", methods=['POST'])
def create_group():
    cursor, conn = connect()
    class_id = request.form.get("class_id")
    session_token = request.form.get("session_token")
    end_time = request.form.get("end_time")
    category = request.form.get("category")
    description = request.form.get("description")
    location_lat = request.form.get("location_lat")
    location_lon = request.form.get("location_lon")
    location_des = request.form.get("location_description")
    chat_id = request.form.get("chat_id")

    # Choose the id associated with the session token
    choose_user_id_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(choose_user_id_stmt, (session_token,))
    user_id = cursor.fetchall()
    if len(user_id) == 0:
        return error_with_message("invalid_session_token")
    userID = user_id[0][0]

    # Check: Check that user is not in another group
    check_user_group_stmt = "SELECT user_id FROM groups WHERE leader_id=%s"
    cursor.execute(check_user_group_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) != 0:
        return error_with_message("user_in_group")

    create_group_stmt = "INSERT INTO groups (class_id, leader_id, end_time, category, description, location_lat, location_lon, location_description, chat_id) VALUES (%s %s %s %s %s %s %s %s %s)"
    cursor.execute(create_group_stmt, (class_id, userID, end_time, category, description, location_lat, location_lon, location_des, chat_id))
    if cursor.rowcount is not 1:
        return error_with_message("creating group failed")

    conn.commit()
    return success_with_data({})
