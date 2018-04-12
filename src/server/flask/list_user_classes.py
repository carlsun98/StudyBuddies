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

    return success_with_data({"classes" : classes})
