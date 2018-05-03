from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
import string
import json
import sys
import copy

cursor, conn = connect()
f = open("courses.json")
data = eval(f.read())
add_class_stmt = "INSERT INTO classes (course_title, course_name, school_id) VALUES (%s, %s, %s)"
school_id = 1

for course in data:
	title = course["title"]
	name = ""
	for listed in course["listings"]:
		name = name + listed["dept"] + " " + listed["number"] + ","
	name = name[:-1]

	cursor.execute(add_class_stmt, (title, name, school_id))
	if cursor.rowcount != 1:
		print("failed to add class")
	conn.commit()