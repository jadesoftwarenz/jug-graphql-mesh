# Create a CloudFormation stack to provision the following resources:
# - A DynamoDB table named jug-transactions
# - An S3 bucket named jug-transactions where transactions.csv files are loaded from
# - A Lambda function to bulk load the jug-transactions table from .csv files in the S3 bucket

aws cloudformation create-stack `
 --stack-name jug-dynamodb-stack `
 --capabilities CAPABILITY_IAM `
 --template-body file://CsvToDynamo.template.json `
 --parameters ParameterKey=BucketName,ParameterValue=jug-transactions `
    ParameterKey=FileName,ParameterValue=transactions.csv `
    ParameterKey=DynamoDBTableName,ParameterValue=Jug-Transactions


## Tear down resources ##

# First empty the S3 bucket (can't remove non-empty bucket)
# aws s3 rm s3://jug-transactions --recursive

# delete the stack
# aws cloudformation delete-stack --stack-name jug-dynamodb-stack
