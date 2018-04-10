from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
Update group API @ /update_group
Input:
    group_id
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

update_group_api = Blueprint('update_group_api', __name__)

@update_group_api.route("/update_group", methods=['POST'])
def update_group():
    cursor, conn = connect()
    group_id = request.form.get("group_id")

    check_group_id_stmt = "SELECT id FROM groups WHERE id=%s"
    cursor.execute(check_group_id_stmt, (group_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("group_does_not_exist")

    choose_defaults_stmt = "SELECT end_time, category, description, location_lat, location_lon, location_description FROM groups WHERE id=%s"
    cursor.execute(choose_defaults_stmt, (group_id,))
    default_end_time = cursor.fetchone()[0]
    default_category = cursor.fetchone()[1]
    default_description = cursor.fetchone()[2]
    default_location_lat = cursor.fetchone()[3]
    default_location_lon = cursor.fetchone()[4]
    default_location_des = cursor.fetchone()[5]

    session_token = request.form.get("session_token")
    end_time = request.form.get("end_time", default_end_time)
    category = request.form.get("category", default_category)
    description = request.form.get("description", default_description)
    location_lat = request.form.get("location_lat", default_location_lat)
    location_lon = request.form.get("location_lon", default_location_lon)
    location_des = request.form.get("location_description", default_location_des)

    choose_user_id_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(choose_user_id_stmt, (session_token,))
    user_id = cursor.fetchall()
    if len(user_id) == 0:
        return error_with_message("invalid_session_token")
    userID = user_id[0][0]

    check_leader_id_stmt = "SELECT COUNT(*) FROM groups WHERE leader_id=%s"
    cursor.execute(check_leader_id_stmt, (userID,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("no_matching_leader_id")
    elif len(results) > 1:
        return error_with_message("multiple_leader_id_matches")

    update_group_stmt = "UPDATE groups SET end_time=%s, category=%s, description=%s, location_lat=%s, location_lon=%s, location_des=%s WHERE id=%s AND leader_id=%s"
    cursor.execute(update_group_stmt, (end_time, category, description, location_lat, location_lon, location_des, group_id, userID))
    if cursor.rowcount is not 1:
        return error_with_message("updating group failed")

    conn.commit()
    return success_with_data({})
