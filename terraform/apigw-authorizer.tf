resource "aws_api_gateway_authorizer" "authorizer" {
    name = local.application_name
    type = "COGNITO_USER_POOLS"
    rest_api_id = aws_api_gateway_rest_api.apigateway.id
    authorizer_credentials = aws_iam_role.api_lambda_role.arn
    provider_arns = data.aws_cognito_user_pools.cognito_user_pool.arns
}

data "aws_cognito_user_pools" "cognito_user_pool" {
  name = var.user_pool_name
}
