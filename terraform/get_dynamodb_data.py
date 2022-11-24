import boto3
import json


def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    # use the DynamoDB object to select our table
    table = dynamodb.Table('HelloWorldDatabase')

    response = table.scan()
    # response = table.scan(FilterExpression=Attr('lName').eq('Dunn') & Attr('city').eq('NYC'))
    data = response['Items']

    while 'LastEvaluatedKey' in response:
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        data.extend(response['Items'])

    print(data)

    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }
