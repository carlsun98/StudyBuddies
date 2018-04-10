from flask import request
from dbconnect import connect
from server_response import success_with_data, error_with_message

def auth_required(function):
	def check_auth(*args, **kwargs):
		cursor, conn = connect()
	    session_token = request.form.get("session_token", "")
	    auth_stmt = "SELECT user_id FROM sessions WHERE token=%s"
	    cursor.execute(auth_stmt, (session_token,))
	    results = cursor.fetchall()
	    if len(results) == 0:
	        return error_with_message("invalid token")

	    user_id = results[0][0]
	    kwargs["user_id"] = user_id
	return check_auth(args, kwargs)