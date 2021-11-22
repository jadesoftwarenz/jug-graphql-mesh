# JADE GraphQL Example

## Architecture

![Alt text](./Architecture.jpg?raw=true "JUG Architectural Diagram")

## Building and Running the GraphQL Mesh Server

First, clone this repo, it contains:

- A DockerFile to build the GraphQL mesh server image
- DockerFiles to build JADE RAP, REST WS Provider and IIS images
- IaC templates and scripts to deploy everything running in Amazon Web Services (AWS)

If you're using Docker for Windows, you'll need to be targeting Linux containers, probably through an integration with WSL2.

Build the container image:

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

## To Stop and Remove the GraphQL Mesh Container

```powershell
# stop the container
docker stop jug-mesh
# remove it 
docker rm jug-mesh
```

## Advanced - Provisioning the Demo Infrastructure in AWS

### Prerequisites

**AWS CLI** – A command line tool for working with AWS services, including Amazon EKS. See [Installing, updating, and uninstalling the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

Note: After you have installed the AWS CLI tool, you should perform a [Quick Setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

**kubectl** – A command line tool for working with Kubernetes clusters. See [Installing kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html).

**eksctl** – A command line tool for working with EKS clusters that automates many individual tasks. See [The eksctl command line utility](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)

**Required IAM permissions** – The IAM security principal that you're using must have permissions to work with Amazon EKS IAM roles and service linked roles, AWS CloudFormation, and a VPC and related resources.

### Provision Resources

cd into the **infrastructure/aws/** directory and run the following scripts.

1. **deploy-eks.ps1**
2. **deploy-dynamo.ps1**

**Script 1** Does the following:

- Creates an Elastic Kubernetes Service (EKS) cluster with linux and windows node groups
- Creates an Elastic Block Store (EBS) Volume to host the JADE database
- Deploys the database server (RAP), REST WS Provider and IIS pods in the cluster

Note: The RAP pod contains a bootstrapping script that will do the following when first deployed:

- Initialise and license the JADE database
- Load application schemas
- Load data

**Script 2** creates a CloudFormation stack to automatically provision the following resources:

- A DynamoDB table named **Jug-Transactions**
- An S3 bucket named **jug-transactions** where **transaction.csv** files are loaded from
- A Lambda function to bulk load the **Jug-Transactions** table from .csv files in the S3 bucket

### Upload the transactions.csv File

1. Sign in to the AWS Management Console and open the Amazon S3 console at (<https://console.aws.amazon.com/s3/>).
2. In the Buckets list, select the **jug-transactions** bucket
3. Choose Upload
4. In the Upload window, do one of the following:

- Drag and drop the **data\transactions.csv** to the Upload window
- Choose Add files, browse to **data\transactions.csv**, and choose Open

Uploading this file will trigger an event that runs the lambda function to load the transactions.csv file into the **Jug-Transactions** DynamoDb table. The data load will take a few minutes to complete, visit <https://console.aws.amazon.com/dynamodbv2/> to check on progress.

### Edit the GraphQL mesh Configuration

1. cd into the top level directory and open **.meshrc.yaml** in a suitable editor
2. Change the host name part of the URL to match the EXTERNAL-IP for the iis-service in the K8s cluster. The EXTERNAL-IP  can be obtained by running **kubectl get svc** from a command shell

## Build and Run the GraphQL Mesh Server

After editing **.meshrc.yaml** you need to (re)build the GraphQL Mesh Server.
Now you are ready to run the GraphQL Mesh Server with your newly provisioned AWS infrastructure.

See above for instructions.

### Tear down resources

When we have finished with the demo, it is good practice to remove the various resources we provisioned to avoid accruing costs.

```powershell
# First empty the S3 bucket (we can't remove a non-empty bucket)
aws s3 rm s3://jug-transactions --recursive
# delete the CloudFormation stack, this will delete all resources the stack provisioned
aws cloudformation delete-stack --stack-name jug-dynamodb-stack
# Use eksctl to delete the EKS cluster 
eksctl delete cluster jug-demo-cluster
```
