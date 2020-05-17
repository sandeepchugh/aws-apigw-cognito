# resource /profile
resource "aws_api_gateway_resource" "profile_apigateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  parent_id   = aws_api_gateway_rest_api.apigateway.root_resource_id
  path_part   = "profile"
}


# method GET
resource "aws_api_gateway_method" "profile_apigateway_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
  resource_id   = aws_api_gateway_resource.profile_apigateway_resource.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
  authorization_scopes = [var.read_scope]
}

resource "aws_api_gateway_integration" "profile_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_get.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.profile_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "profile_get_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_get.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_get.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "profile_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_get.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_get.http_method
  status_code = aws_api_gateway_method_response.profile_get_response.status_code

  depends_on = [aws_api_gateway_integration.profile_get_integration]
}

# method POST
resource "aws_api_gateway_method" "profile_apigateway_post" {
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
  resource_id   = aws_api_gateway_resource.profile_apigateway_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
  authorization_scopes = [var.write_scope]
}

resource "aws_api_gateway_integration" "profile_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_post.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.profile_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "profile_post_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_post.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_post.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "profile_post_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_post.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_post.http_method
  status_code = aws_api_gateway_method_response.profile_post_response.status_code

  depends_on = [aws_api_gateway_integration.profile_post_integration]
}

# method PUT
resource "aws_api_gateway_method" "profile_apigateway_put" {
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
  resource_id   = aws_api_gateway_resource.profile_apigateway_resource.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
  authorization_scopes = [var.write_scope]
}

resource "aws_api_gateway_integration" "profile_put_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_put.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_put.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.profile_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "profile_put_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_put.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_put.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "profile_put_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_put.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_put.http_method
  status_code = aws_api_gateway_method_response.profile_put_response.status_code

  depends_on = [aws_api_gateway_integration.profile_put_integration]
}

# method DELETE
resource "aws_api_gateway_method" "profile_apigateway_delete" {
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
  resource_id   = aws_api_gateway_resource.profile_apigateway_resource.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
  authorization_scopes = [var.delete_scope]
}

resource "aws_api_gateway_integration" "profile_delete_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_delete.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_delete.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.profile_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "profile_delete_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_delete.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_delete.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "profile_delete_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_delete.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_delete.http_method
  status_code = aws_api_gateway_method_response.profile_delete_response.status_code

  depends_on = [aws_api_gateway_integration.profile_delete_integration]
}

# resource /profile OPTIONS

resource "aws_api_gateway_method" "profile_apigateway_options" {
  rest_api_id   = aws_api_gateway_rest_api.apigateway.id
  resource_id   = aws_api_gateway_resource.profile_apigateway_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "profile_options_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_options.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = <<EOF
{"statusCode":200}
EOF
  }
}

resource "aws_api_gateway_method_response" "profile_options_response_200" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_options.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_options.http_method
  status_code = "200"

  response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true
      "method.response.header.Access-Control-Allow-Methods" = true
      "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "profile_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_method.profile_apigateway_options.resource_id
  http_method = aws_api_gateway_method.profile_apigateway_options.http_method
  status_code = aws_api_gateway_method_response.profile_options_response_200.status_code

  response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization'"
      "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}