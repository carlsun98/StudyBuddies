from flask import request
from server_response import success_with_data, error_with_message
from functools import wraps

def verify_required_keys(required_keys):
	def _verify_required_keys(f):
		@wraps(f)
		def check_required_keys(*args,**kwargs):
			keys = list(request.form.keys())
			if set(required_keys) <= set(keys):
				return f(*args, **kwargs)
			return error_with_message("msg_not_all_required_keys_provided")
		return check_required_keys
	return _verify_required_keys
