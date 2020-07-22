import json
import logging
import os

import jsons
from src import profile_handler, request


def format_response(status_code, body):
    """
    formats the lambda response to api gateway response format
    :param status_code: response status code
    :param body: response body
    :return: dict
    """
    return {
        "statusCode": status_code,
        "body": json.dumps(body)
    }


def function_handler(event, context):
    """
    Lambda function handler
    :param event: aws api gateway event
    :param context: lambda context
    :return: formatted response for api gateway output
    """
    logger = logging.getLogger(__name__)
    logger.setLevel(os.environ["LogLevel"])
    logger.info('Entering lambda_function.function_handler')

    request_params = request.parse_request(event)
    http_method = event.get("httpMethod", None)

    try:
        if http_method == "GET":
            logger.info("Getting profile for user id {} and organization id {}"
                        .format(request_params["user_id"], request_params["org_id"]))
            user_profile = profile_handler.get_user_profile(request_params["user_id"], request_params["org_id"])
            if user_profile is None:
                return format_response(404, None)
            return format_response(200, user_profile)
        elif http_method == "POST" or http_method == "PUT":
            user_profile = jsons.loads(event["body"])
            profile_handler.save_user_profile(user_profile)
            return format_response(200, None)
        elif http_method == "DELETE":
            profile_handler.delete_user_profile(request_params["user_id"], request_params["org_id"])
        else:
            return format_response(500, "{} requests are not supported".format(http_method))
    except Exception as e:
        logger.error("Failed to complete request: {}".format(str(e)))
        format_response(500, "Request failed")