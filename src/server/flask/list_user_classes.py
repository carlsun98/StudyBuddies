from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import random, string

'''
List user classes API @ /list_user_classes
Input:
    session_token
Output:
    list of classes
'''

list_user_classes_api = Blueprint('list_user_classes_api', __name__)

@list_user_classes_api.route("/list_user_classes", methods=['POST'])
def list_user_classes():
    cursor, conn = connect()
    session_token = request.form.get("session_token", "")
    print (session_token)
    auth_stmt = "SELECT user_id FROM sessions WHERE token=%s"
    cursor.execute(auth_stmt, (session_token,))
    results = cursor.fetchall()
    if len(results) == 0:
        return error_with_message("invalid token")

    user_id = results[0][0]

    user_classes_stmt = """SELECT 
    classes.id, course_title, course_abbreviation, course_number 
    FROM classes LEFT JOIN user_classes ON 
    classes.id = user_classes.class_id 
    WHERE user_classes.user_id = %s"""

    cursor.execute(user_classes_stmt, (user_id,))
    classes = cursor.fetchall()

    return success_with_data({"classes" : classes})