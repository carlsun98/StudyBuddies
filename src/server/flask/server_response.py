from flask import jsonify

# template success and failure API responses
def success_with_data(data):
    response = [{"success" : 1, "message" : ""}, data]
    return jsonify(response)

def error_with_message(message):
    response = [{"success" : 0, "message" : message}]
    return jsonify(response)