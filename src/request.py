

def parse_request(event):
    """
    Parses the input api gateway event and returns the product id
    Expects the input event to contain the pathPatameters dict with
    the user id and school id key/value pair
    :param event: api gateway event
    :return: a dict containing the user id and org id
    """
    query_params = event.get("queryStringParameters", {})

    return {
        "user_id": query_params.get('user_id', None),
        "org_id": query_params.get('org_id', None),
    }
