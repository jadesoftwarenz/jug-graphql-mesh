import { DynamoDBClient, QueryCommand } from "@aws-sdk/client-dynamodb";
import { Resolvers } from "../.mesh";

const client = new DynamoDBClient({
  region: process.env.AWS_REGION || "ap-southeast-2",
});

export const resolvers: Resolvers = {
  FCAccount: {
    transactions: async (root) => {
      const accountId = root.id;

      if (!accountId) {
        throw new Error("Account ID is required");
      }

      const command = new QueryCommand({
        TableName: process.env.TRANSACTIONS_TABLE_NAME || "Jug-Transactions",
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

      if (response.Items) {
        return {
          count: response.Count || 0,
          items: response.Items.map((item) => {
            return {
              timestamp: item.timestamp.S!,
              type: item.type.S!,
              trans_id: item.trans_id.S!,
              amount: item.amount.S!,
            };
          }),
        };
      } else {
        return {
          count: 0,
          items: [],
        };
      }
    },
  },
};
