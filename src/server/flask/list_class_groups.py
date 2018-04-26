from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
from auth import auth_required

'''
List active groups in user subscribed classes API @ /list_class_groups
Input:
    session_token
Output:
    list of groups
'''

list_class_groups_api = Blueprint('list_class_groups_api', __name__)

@list_class_groups_api.route("/list_class_groups", methods=['POST'])
@auth_required
def list_class_groups(**kwargs):
    cursor, conn = connect()
    user_id = kwargs["user_id"]
    class_groups_stmt = """SELECT
    groups.id, leader_id, start_time,
    end_time, category, groups.description,
    location_lat, location_lon, location_description,
    classes.id, course_title, course_name
    FROM groups
    LEFT JOIN classes ON
    groups.class_id = classes.id
    LEFT JOIN user_classes ON
    classes.id = user_classes.class_id
    WHERE user_classes.user_id = %s"""

    cursor.execute(class_groups_stmt, (user_id,))
    results = cursor.fetchall()

    resultsDict = []
    for result in results:
        group_id = result[0]
        leader_id = result[1]
        start_time = result[2]
        end_time = result[3]
        category = result[4]
        group_description = result[5]
        location_lat = result[6]
        location_lon = result[7]
        location_description = result[8]
        class_id = result[9]
        course_title = result[10]
        course_name = result[11]

        result = {
            "group_id": group_id,
            "leader_id": leader_id,
            "start_time": start_time,
            "end_time": end_time,
            "category": category,
            "group_description": group_description,
            "location_lat": location_lat,
            "location_lon": location_lon,
            "location_description": location_description,
            "class_id": class_id,
            "course_title": course_title,
            "course_name": course_name
        }
        resultsDict.append(result)

    return success_with_data({"groups" : resultsDict})
