from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required
from verify import verify_required_keys

'''
List user classes API @ /list_user_classes
Input:
    session_token
Output:
    current group?
'''

REQUIRED_KEYS = ["session_token"]

get_current_group_api = Blueprint('get_current_group_api', __name__)

@get_current_group_api.route("/get_current_group", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def get_current_group(**kwargs):
    user_id = kwargs["user_id"]
    current_group_stmt = """SELECT
    group_id
    FROM users
    WHERE id = %s"""

    cursor, conn = connect()
    cursor.execute(current_group_stmt, (user_id,))
    group_id = cursor.fetchone()[0]

    if group_id == -1:
        return success_with_data({"group": {"id" : -1}})

    group_exists_stmt = "SELECT COUNT(*) FROM groups WHERE id=%s"
    cursor.execute(group_exists_stmt, (group_id,))
    size = cursor.fetchone()[0]
    if size == 0:
        return success_with_data({"group": {"id" : -1}})


    get_group_stmt = """SELECT id, leader_id, start_time, end_time,
    category, description, location_lat, location_lon, location_description,
    chat_id, class_id FROM groups WHERE id = %s"""
    cursor.execute(get_group_stmt, (group_id,))
    the_group = cursor.fetchone()
    group_id = the_group[0]
    leader_id = the_group[1]
    start_time = the_group[2]
    end_time = the_group[3]
    category = the_group[4]
    description = the_group[5]
    location_lat = the_group[6]
    location_lon = the_group[7]
    location_description = the_group[8]
    chat_id = the_group[9]
    course_id = the_group[10]
    get_size_stmt = "SELECT COUNT(*) FROM users WHERE group_id=%s"
    cursor.execute(get_size_stmt, (group_id,))
    size = cursor.fetchone()[0]
    get_class_stmt = "SELECT id, course_title, course_name, school_id FROM classes WHERE id=%s"

    cursor.execute(get_class_stmt, (course_id,))
    course_data = cursor.fetchone()
    id = course_data[0]
    course_title = course_data[1]
    course_name = course_data[2]
    school_id = course_data[3]
    group_result = {
        "id": group_id,
        "leader_id": leader_id,
        "start_time": str(start_time),
        "end_time": str(end_time),
        "category": category,
        "description": description,
        "location_lat": location_lat,
        "location_lon": location_lon,
        "location_description": location_description,
        "chat_id": chat_id,
        "course": {"id": id, "course_title": course_title, "course_name": course_name, "school_id": school_id},
        "size": size
    }
    return success_with_data({"group" : group_result})
