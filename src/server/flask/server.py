## TODO: make api RESTFUL. Shouldn't be too much work, and would look a lot nicer

from flask import Flask, g, jsonify, request
from dbconnect import connect
from server_response import success_with_data, error_with_message

from login import login_api
from create_user import create_user_api
from update_user import update_user_api
from delete_user import delete_user_api
from list_user_classes import list_user_classes_api
from list_class_groups import list_class_groups_api
from add_class import add_class_api
from delete_class import delete_class_api
from classes_list import classes_list_api
from create_group import create_group_api
from join_group import join_group_api
from update_group import update_group_api
from delete_group import delete_group_api
from leave_group import leave_group_api
from change_leader import change_leader_api
from lost_account import lost_account_api
from confirm_email import confirm_email_api
from account_recovery import account_recovery_api

app = Flask(__name__)

app.register_blueprint(login_api)
app.register_blueprint(create_user_api)
app.register_blueprint(update_user_api)
app.register_blueprint(delete_user_api)
app.register_blueprint(list_user_classes_api)
app.register_blueprint(list_class_groups_api)
app.register_blueprint(add_class_api)
app.register_blueprint(delete_class_api)
app.register_blueprint(classes_list_api)
app.register_blueprint(create_group_api)
app.register_blueprint(update_group_api)
app.register_blueprint(join_group_api)
app.register_blueprint(delete_group_api)
app.register_blueprint(leave_group_api)
app.register_blueprint(change_leader_api)
app.register_blueprint(lost_account_api)
app.register_blueprint(confirm_email_api)
app.register_blueprint(account_recovery_api)

# test page
@app.route('/')
def index():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', ssl_context='adhoc')
