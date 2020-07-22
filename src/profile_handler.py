import logging
import boto3
import jsons
from botocore.exceptions import ClientError
from src import config
logger = logging.getLogger('lambda_function')


def get_user_profile(user_id, org_id):
    """
    Gets the user profile
    :param user_id: user id
    :param org_id: org id
    :return: dict
    """
    config_settings = config.get_config()
    db_client = boto3.resource('dynamodb', region_name=config_settings['region'])
    table = db_client.Table(config_settings['table_name'])

    try:
        response = table.get_item(Key={'user_id':str(user_id), 'org_id': str(org_id)})
    except ClientError as e:
        logger.error("Failed to retrieve profile for user {} and organization {}:{}"
                     .format(user_id, org_id, e.response['Error']['Message']))
    else:
        if "Item" in response:
            return response["Item"]

    return None


def delete_user_profile(user_id, org_id):
    """
        Deletes the user profile
        :param user_id: user id
        :param org_id: org id
        :return: None
        """
    config_settings = config.get_config()
    db_client = boto3.resource('dynamodb', region_name=config_settings['region'])
    table = db_client.Table(config_settings['table_name'])

    try:
        response = table.delete_item(Key={'user_id': user_id, 'org_id': org_id})
    except ClientError as e:
        logger.error("Failed to delete profile for user {} and organization {}:{}"
                     .format(user_id, org_id, e.response['Error']['Message']))


def save_user_profile(user_profile):
    """
    Saves the user profile
    :param user_profile: user profile dict
    :return: None
    """
    config_settings = config.get_config()
    db_client = boto3.resource('dynamodb', region_name = config_settings['region'])
    table = db_client.Table(config_settings['table_name'])

    try:
        table.put_item(Item=user_profile)
    except ClientError as e:
        logger.error("Failed to save profile {}:{}"
                     .format(jsons.dumps(user_profile), e.response['Error']['Message']))
