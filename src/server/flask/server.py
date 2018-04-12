## TODO: make api RESTFUL. Shouldn't be too much work, and would look a lot nicer

from flask import Flask, g, jsonify, request
from dbconnect import connect
from server_response import success_with_data, error_with_message

from login import login_api
from create_user import create_user_api
from list_user_classes import list_user_classes_api
from list_class_groups import list_class_groups_api
from add_class import add_class_api
from delete_class import delete_class_api
from classes_list import classes_list_api
from create_group import create_group_api
from update_group import update_group_api

app = Flask(__name__)

app.register_blueprint(login_api)
app.register_blueprint(create_user_api)
app.register_blueprint(list_user_classes_api)
app.register_blueprint(list_class_groups_api)
app.register_blueprint(add_class_api)
app.register_blueprint(delete_class_api)
app.register_blueprint(classes_list_api)
app.register_blueprint(create_user_api)
app.register_blueprint(update_group_api)

# test page
@app.route('/')
def index():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', ssl_context='adhoc')
