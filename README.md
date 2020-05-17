# Api using AWS API Gateway, Lambda and AWS Cognito

Profile api using aws api gateway , lambda and dynamodb secured using cognito

## Deployment
### Terraform

DEVELOPMENT
```shell script
terraform -backend-config dev.tfbackend
terraform plan -var-file dev.tfvars
```

PRODUCTION
```shell script
terraform -backend-config prod.tfbackend
terraform plan -var-file prod.tfvars
```

