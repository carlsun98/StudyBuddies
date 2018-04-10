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

classes_list_api = Blueprint('classes_list_api', __name__)

@classes_list_api.route("/classes_list", methods=['POST'])
def classes_list():
    cursor, conn = connect()
    session_token = request.form.get("session_token")
    search_string = request.form.get("search_string")
    find_session_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(find_session_stmt, (session_token))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid_session")

    user_id = results[0][0]

    get_school_stmt = "SELECT school_id FROM users WHERE id=%d"
    cursor.execute(get_school_stmt, (user_id))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("school does not exist")
    school_id = results[0][0]

    get_classes_stmt = "SELECT course_title, course_abbreviation, course_number FROM groups WHERE school_id=%d"
    cursor.execute(get_leader_stmt, (group_id))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("no classes match the search")

    search_results = [][]

    for course in results:
        if re.search(search_string, course[0]) is not None:
            search_results.push(course)
            continue

        if re.search(search_string, course[1]) is not None:
            search_results.push(course)
            continue

        if re.search(search_string, course[2]) is not None:
            search_results.push(course)
            continue

    if len(search_results) == 0:
        return error_with_message("no classes match the search")

    return search_results