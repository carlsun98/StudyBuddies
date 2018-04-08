from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
List active groups in user subscribed classes API @ /list_class_groups
Input:
    session_token
Output:
    list of groups
'''

list_class_groups_api = Blueprint('list_class_groups_api', __name__)

@list_class_groups_api.route("/list_class_groups", methods=['POST'])
def list_class_groups():
    cursor, conn = connect()
    session_token = request.form.get("session_token", "")
    print (session_token)
    auth_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(auth_stmt, (session_token,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid token")

    user_id = results[0][0]

    class_groups_stmt = """SELECT 
    groups.*, classes.id, course_title, course_abbreviation, course_number 
    FROM groups 
    LEFT JOIN classes ON 
    groups.class_id = classes.id
    LEFT JOIN user_classes ON
    classes.id = user_classes.class_id
    WHERE user_classes.user_id = %s"""

    cursor.execute(class_groups_stmt, (user_id,))
    classes = cursor.fetchall()

    return success_with_data({"groups" : classes})