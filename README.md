# JADE GraphQL Example

## Instructions
First, check out this repo. It contains a Dockerfile so managing dependencies should be easy :) Ensure Docker is working correctly. If you're using Docker for Windows, you'll need to be targetting Linux containers, probably through an integration with WSL2.

Next, build the container:
```bash  
docker build -t jug-graphql-mesh .
```

You'll need to provision a DynamoDB database with some transactions. You can run this script to do so:

```bash
!! TODO !!
bash scripts/populate-dynamo.sh
```

Then, run the Docker container:

```bash
docker run --it \
-e AWS_ACCESS_KEY_ID=xxx \
-e AWS_SECRET_ACCESS_KEY=xxx \
-e AWS_REGION=ap-southeast-2 \
-p 4000:4000 \
jug-graphql-mesh
```

(where `xxx` is your AWS IAM access key ID and secret key)

Then, if you navigate to http://localhost:4000, you will see a GraphQL explorer where you can try out the JADE GraphQL Mesh.

## Example Query

```graphql
query MyQuery {
  getAccountId(id: "A00003558") {
    id
    transactions {
      count
      items {
        timestamp
        type
        amount
      }
    }
  }
}
```
