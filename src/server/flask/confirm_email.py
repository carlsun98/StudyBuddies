from flask import Blueprint, request
from dbconnect import connect
from server_response import success_with_data, error_with_message

confirrm_email_api = Blueprint('confirm_email_api', __name__)

'''Add class API @ /add_class
Input:
    confirmation token
Output:
    confirmation success/failure message
'''

@login_api.route("/confirm_email/<confirmation_token>", methods=['GET'])
def confirm_email(confirmation_token):
    cursor, conn = connect()
    confirm_email_stmt = "SELECT user_id FROM email_confirmations WHERE token=%s"
    cursor.execute(confirm_email_stmt, (confirmation_token,))
    result = cursor.fetchone()
    if len(result) == 0:
        return "Invalid confirmation"
    user_id = result[0][0]

    update_acct_stmt = "UPDATE users SET account_confirmed=1 WHERE id=%s"
    cursor.execute(update_acct_stmt, (user_id,))
    conn.commit()
    return "Thanks for confirming your account. Click here to go back to the app"