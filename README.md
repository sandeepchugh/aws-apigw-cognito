# Api using AWS API Gateway, Lambda and AWS Cognito

### What is this?
This is a demo project of a user profile api using the following AWS services:
- Api Gateway 
- AWS Lambda 
- Dynamodb
- AWS Cognito (for security)

The purpose of the demo is to use terraform to deploy a python aws lambda using
aws dynamodb database and exposed via an aws api gateway. The api is secured via
aws cognito

### What language is this developed in?
The code is in python 3.x. The IAC(Infrastructure as code) code is Terraform and tests use pytest and behave

### How is this deployed?
The project uses terraform to deploy the resources and depencencies in AWS.

Install terraform in your local machine or build server using terraform cli
https://www.terraform.io/downloads.html

Terraform uses the aws provider to interact with aws services. More details on 
the aws provider are available at 
https://www.terraform.io/docs/providers/aws/index.html

Note: Add ZoneId in git 

#### IAC (Terraform)

DEVELOPMENT
```shell script
terraform init -backend-config dev.tfbackend
terraform plan -var-file dev.tfvars
terraform apply -var-file dev.tfvars

```

PRODUCTION
```shell script
terraform init -backend-config prod.tfbackend
terraform plan -var-file prod.tfvars
terraform apply -var-file prod.tfvars
```

### How does this work?

#### curl
```shell script


```
