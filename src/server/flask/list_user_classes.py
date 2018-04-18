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
    list of classes
'''

REQUIRED_KEYS = ["session_token"]

list_user_classes_api = Blueprint('list_user_classes_api', __name__)

@list_user_classes_api.route("/list_user_classes", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def list_user_classes(**kwargs):
    user_id = kwargs["user_id"]
    user_classes_stmt = """SELECT
    classes.id, course_title, course_abbreviation, course_number
    FROM classes LEFT JOIN user_classes ON
    classes.id = user_classes.class_id
    WHERE user_classes.user_id = %s"""

    cursor, conn = connect()
    cursor.execute(user_classes_stmt, (user_id,))
    classes = cursor.fetchall()

    resultsDict = []
    for the_class in classes:
        groups = []
        get_group_stmt = """SELECT id, leader_id, start_time, end_time, 
        category, description, location_lat, location_lon, location_description, 
        chat_id WHERE class_id=%s"""
        cursor.execute(get_group_stmt, (the_class[0],))
        group_list = cursor.fetchall()
        for the_group in group_list:
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
            group_result = {
                "id": group_id
                "leader_id": leader_id
                "start_time": start_time
                "end_time": end_time
                "category": category
                "description": description
                "location_lat": location_lat
                "location_lon": location_lon
                "chat_id": chat_id
            }
            groups.append(group_result)

        id = the_class[0]
        course_title = the_class[1]
        course_abbreviation = the_class[2]
        course_number = the_class[3]
        result = {
            "id": id,
            "course_title": course_title,
            "course_abbreviation": course_abbreviation,
            "course_number": course_number
            "active_groups": groups
        }
        resultsDict.append(result)
    return success_with_data({"classes" : resultsDict})
