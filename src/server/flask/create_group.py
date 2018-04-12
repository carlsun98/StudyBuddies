from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
from auth import auth_required

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

REQUIRED_KEYS = ["class_id",
                 "end_time",
                 "category",
                 "description",
                 "location_lat",
                 "location_lon",
                 "location_description"]

create_group_api = Blueprint('create_group_api', __name__)

@create_group_api.route("/create_group", methods=['POST'])
@auth_required
def create_group(**kwargs):
    userID = kwargs["user_id"]
    cursor, conn = connect()
    class_id = request.form.get("class_id")
    end_time = request.form.get("end_time")
    category = request.form.get("category")
    description = request.form.get("description")
    location_lat = request.form.get("location_lat")
    location_lon = request.form.get("location_lon")
    location_des = request.form.get("location_description")
    chat_id = request.form.get("chat_id")

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
