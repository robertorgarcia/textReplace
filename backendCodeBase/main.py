
import urllib
import os
import sys
import json


def lambda_handler(event, context):
    print(event)
    body = json.loads(event['body'])
    body = body['textbody']
    bodyOut = body.replace("Oracle","Oracle©")
    bodyOut = bodyOut.replace("Google","Google©")
    bodyOut = bodyOut.replace("Microsoft","Microsoft©")
    bodyOut = bodyOut.replace("Amazon","Amazon©")
    bodyOut = bodyOut.replace("Deloitte","Deloitte©")
    return {
        'statusCode': 200,
        'body': json.dumps({"message":bodyOut})
    }