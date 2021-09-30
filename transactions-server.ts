import { DynamoDBClient, QueryCommand } from "@aws-sdk/client-dynamodb";
import { IncomingMessage, ServerResponse } from "http";
import match from "micro-route/match";

const client = new DynamoDBClient({
  region: process.env.AWS_REGION || "ap-southeast-2",
});

async function fetchAccountTransactions(accountId: string) {
  if (!accountId) {
    throw new Error("Account ID is required");
  }

  const command = new QueryCommand({
    TableName: process.env.TRANSACTIONS_TABLE_NAME || "Transactions",
    KeyConditionExpression: "#aid = :account_id",
    ExpressionAttributeNames: {
      "#aid": "account_id",
    },
    ExpressionAttributeValues: {
      ":account_id": {
        S: accountId,
      },
    },
  });

  const response = await client.send(command);

  return response.Items || [];
}

export default (req: IncomingMessage, res: ServerResponse) => {
  const { params, query } = match(req, "/:accountId", true);
  console.log(params, query);
  return "ok";
};
