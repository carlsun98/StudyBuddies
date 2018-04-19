from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message
from verify import verify_required_keys
import random, string
import smtplib

'''
Lost account API @ /lost_account
Input:
    email ID
Output:
    success/failure
'''

REQUIRED_KEYS = ["email"]

lost_account_api = Blueprint('lost_account_api', __name__)

@lost_account_api.route('/lost_account', methods=['POST'])
@verify_required_keys(REQUIRED_KEYS)
def lost_account():
    cursor, conn = connect()
    email = request.form.get("email")

    check_existing_users_stmt = "SELECT user_id FROM users WHERE email=%s"
    cursor.execute(check_existing_users_stmt, (email))
    result = cursor.fetchall()
    if len(result) is not 1:
        return error_with_message("user does not exist")

    user_id = result[0][0]

    create_recovery_stmt = "INSERT INTO password_recovery (user_id, recovery_token) VALUES (%s, %s)"
    recovery_token = ''.join(random.choice(string.ascii_letters +
                                          string.digits) for _ in range(32))
    cursor.execute(create_recovery_stmt, (user_id, recovery_token))
    if cursor.rowcount is not 1:
        return error_with_message("account recovery failed")
    conn.commit()

    # Send confirmation email
    FROM = "thestudybuddiesapp@gmail.com"
    TO = [email]
    SUBJECT = "Recover your StudyBuddy Account"
    MSG = ("Hello " + name +
    ",\nYou have requested to recovery your account. Please change your password by visiting this link: " +
    "http://34.214.169.181:5000/account_recovery?recovery_token="+recovery_token+"\n"+
    "\nThank you,\nThe StudyBuddies Team")
    message = 'Subject: {}\n\n{}'.format(SUBJECT, MSG)
    server = smtplib.SMTP('localhost')
    server.sendmail(FROM, TO, message)
    server.quit()
    print(message)
    return success_with_data({"confirmation_token" : recovery_token})
