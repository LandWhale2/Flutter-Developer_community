// var AWS = require('aws-sdk')
// AWS.config.update({
//     region: 'ap-northeast-2',
//     endpoint: "http://dynamodb.ap-northeast-2.amazonaws.com"    
// })
// const dynamodb =new AWS.DynamoDB()
// tableName = 'Food'
// const params = {
//     TableName: tableName,
//     KeySchema: [
//         {AttributeName: "type", KeyType: "HASH"},
//         {AttributeName: "name", KeyType: "RANGE"}
//     ],
//     AttributeDefinitions: [
//         {AttributeName: "type", AttributeType: "S"},
//         {AttributeName: "name", AttributeType: "S"}
//     ],
//     ProvisionedThroughput: {
//         ReadCapacityUnits: 1,
//         WriteCapacityUnits: 1
//     }
// }
// dynamodb.createTable(params).promise()
//     .then(req => {
//         console.log(req)
//     })
//     .catch(err => {
//         console.log(err)
//     })


// const docClient = new AWS.DynamoDB.DocumentClient()
// const tableName = "Food"
// const params = {
//         TableName: tableName,
//         Item: {
//             "type": "Western",
//             "name": "Carbonara",
//             "price": 13000,
//             "ingredients": {
//                 "egg": "1",
//                 "spaghetti": "90g",
//                 "garlic": "1",
//                 "bacon": "50g"
//             }
//         }
// }
// docClient.put(params).promise()
//         .then(req => {
//             console.log(req)
//         })
//         .catch(err => {
//             console.log(err)
//         })
const data = fs.readFileSync("recipes.json")
const recipes = JSON.parse(data)
for(let index in recipes.items) {
    let item = recipes.items[index]
    const params = {
        TableName: tableName,
        Item: item
    }
    docClient.put(params).promise()
        .then(req => {
            console.log(req)
        })
        .catch(err => {
            console.log(err)
        })
}