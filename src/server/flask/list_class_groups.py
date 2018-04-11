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
    user_id = kwargs["user_id"]
    class_groups_stmt = """SELECT
    groups.*, classes.id, course_title, course_abbreviation, course_number
    FROM groups
    LEFT JOIN classes ON
    groups.class_id = classes.id
    LEFT JOIN user_classes ON
    classes.id = user_classes.class_id
    WHERE user_classes.user_id = %s"""

    cursor.execute(class_groups_stmt, (user_id,))
    groups = cursor.fetchall()

    return success_with_data({"groups" : groups})
