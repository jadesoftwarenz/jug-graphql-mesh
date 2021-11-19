# JADE GraphQL Example

## Architecture

![Alt text](./architecture.jpg?raw=true "JUG Architectural Diagram")

## Instructions

First, check out this repo. It contains a Dockerfile so managing dependencies should be easy :) Ensure Docker is working correctly. If you're using Docker for Windows, you'll need to be targeting Linux containers, probably through an integration with WSL2.

Next, build the container:

```powershell
docker build -t jug-graphql-mesh .
```

Then, run the Docker container:

```powershell
 docker run -d `
 -e AWS_ACCESS_KEY_ID=XXX `
 -e AWS_SECRET_ACCESS_KEY=XXX `
 -e AWS_REGION=ap-southeast-2 `
 -p 4000:4000 `
 --name jug-mesh jug-graphql-mesh 
```

(where `xxx` is your AWS IAM access key ID and secret key)

Then, if you navigate to <http://localhost:4000>, you will see a GraphQL explorer where you can try out the JADE GraphQL Mesh.

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

## To Stop the GraphQL Mesh Container

```powershell
docker stop jug-mesh
```
