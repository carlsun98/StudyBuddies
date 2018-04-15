from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
from auth import auth_required
from verify import verify_required_keys

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
@verify_required_keys(REQUIRED_KEYS)
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

    # Check: Check that user is not in another group
    check_user_group_stmt = "SELECT user_id FROM groups WHERE leader_id=%d"
    cursor.execute(check_user_group_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) != 0:
        return error_with_message("msg_user_already_in_group")

    create_group_stmt = "INSERT INTO groups (class_id, leader_id, end_time, category, description, location_lat, location_lon, location_description) VALUES (%d %d %s %s %s %f %f %s)"
    cursor.execute(create_group_stmt, (class_id, userID, end_time, category, description, location_lat, location_lon, location_des))
    if cursor.rowcount is not 1:
        return error_with_message("msg_creating_group_failed")
    group_id = cursor.lastrowid
    conn.commit()
    return success_with_data({"group_id": group_id})
