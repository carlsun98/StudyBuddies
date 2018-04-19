from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
from verify import verify_required_keys
import random, string
import smtplib

'''
Create user API @ /create_user
Input:
    email
    password
    name
    class_year
Output:
    none
'''

REQUIRED_KEYS = ["email", "password", "name", "class_year"]

create_user_api = Blueprint('create_user_api', __name__)

@create_user_api.route('/create_user', methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
def create_user():
    cursor, conn = connect()
    email = request.form.get("email")
    password = request.form.get("password")
    name = request.form.get("name")
    class_year = request.form.get("class_year")

    check_existing_users_stmt = "SELECT COUNT(*) FROM users WHERE email=%s"
    cursor.execute(check_existing_users_stmt, (email,))
    count = cursor.fetchone()[0]
    if count is not 0:
        return error_with_message("user already exists")

    create_user_stmt = "INSERT INTO users (email, password, name, class_year) VALUES (%s, %s, %s, %s)"
    cursor.execute(create_user_stmt, (email, password, name, class_year))
    if cursor.rowcount is not 1:
        return error_with_message("creating user failed")
    conn.commit()

    user_id = cursor.lastrowid
    confirmation_token = ''.join(random.choice(string.ascii_letters +
                                          string.digits) for _ in range(32))
    create_confirmation_stmt = "INSERT INTO email_confirmations (user_id, token) VALUES (%s, %s)"
    cursor.execute(create_confirmation_stmt, (user_id, confirmation_token))
    conn.commit()

    # Send confirmation email
    FROM = "thestudybuddiesapp@gmail.com"
    TO = [email]
    SUBJECT = "Confirm your StudyBuddy Account"
    MSG = ("Hello " + name +
    ",\nPlease confirm your account by visiting this link: " +
    "http://34.214.169.181:5000/confirm_email/"+confirmation_token+"\n"+
    "\nThank you,\nThe StudyBuddies Team")
    message = 'Subject: {}\n\n{}'.format(SUBJECT, MSG)
    server = smtplib.SMTP('localhost')
    server.sendmail(FROM, TO, message)
    server.quit()
    print(message)
    return success_with_data({"confirmation_token" : confirmation_token})
