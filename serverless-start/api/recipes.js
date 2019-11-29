'use strict';
​
const AWS = require('aws-sdk');
​
AWS.config.update({
    region: 'ap-northeast-2',
    endPoint: 'http://dynamodb.ap-northeast-2.amazonaws.com'
});
​
const docClient = new AWS.DynamoDB.DocumentClient();
const TableName =  'Food';
​
module.exports.get = async (event, callback) => {
    let queryParam = event.queryStringParameters;
    let  type  = queryParam['type'];
    const name = queryParam['name'];
​
    const params = {
        TableName : TableName,
        Key : {
            "type": type,
            "name": name,
        }
    }
​
    const result = await docClient.get(params).promise();
​
    const response = {
        statusCode: 200,
        body: JSON.stringify(result)
    }
​
    return response;
}
​
module.exports.query = async (event, callback) => {
    const { type } = event.pathParameters;
​
    const params = {
        TableName: TableName,
        KeyConditionExpression: "#type = :type",
        ExpressionAttributeNames: {
            "#type": "type"
        },
        ExpressionAttributeValues: {
            ":type": type
        }
    }
​
    const result = await docClient.query(params).promise();
    const response = {
        statusCode: 200,
        body: JSON.stringify(result['Items'])
    }
​
    console.log(result);
​
    return response;
}