
import urllib
import os
import sys
import json
from functools import reduce


def lambda_handler(event, context):
    print(event)
    # extract text to be replaced - following the message schema provided by AWS and our OpenAPI schema
    body = json.loads(event['body'])
    bodyOut = body['textbody']

    # setup replacement chain
    replacements = (('Oracle','Oracle©'),('Google','Google©'),('Microsoft','Microsoft©'),('Amazon','Amazon©'),('Deloitte','Deloitte©'))
    for i in replacements:
        bodyOut = bodyOut.replace(*i)

    # setup return message as per OpenAPI schema spec
    return {
        'statusCode': 200,
        'body': json.dumps({"message":bodyOut})
    }