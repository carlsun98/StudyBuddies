from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string
import re

'''
Login API @ /login
Input:
    email
    password
Output:
    session token
'''

REQUIRED_KEYS = ["session_token"]

classes_list_api = Blueprint('classes_list_api', __name__)

@classes_list_api.route("/classes_list", methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
@auth_required
def classes_list(**kwargs):
    cursor, conn = connect()
    search_string = request.form.get("search_string","(.*?)")

    user_id = kwargs["user_id"]

    get_school_stmt = "SELECT school_id FROM users WHERE id=%s"
    cursor.execute(get_school_stmt, (user_id,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("msg_nonexistant_school")
    school_id = results[0][0]

    get_classes_stmt = "SELECT id, course_title, course_abbreviation, course_number FROM classes WHERE school_id=%s"
    cursor.execute(get_classes_stmt, (school_id,))
    results = cursor.fetchall()

    search_results = [][]

    for course in results:
        if re.search(search_string, course[0]) is not None:
            search_results.push(course)
        else if re.search(search_string, course[1]) is not None:
            search_results.push(course)
        else if re.search(search_string, course[2]) is not None:
            search_results.push(course)

    return success_with_data(search_results)
