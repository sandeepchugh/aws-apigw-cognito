import logging
import os


def get_config():
    """
    Returns the lambda configuration from the environment variables
    :return: dict containing log_level, region, table_name
    """
    return {
        "log_level": os.environ.get('LogLevel', logging.INFO),
        "region": os.environ.get('Region', "us-east-2"),
        "table_name": os.environ['TableName']
    }
