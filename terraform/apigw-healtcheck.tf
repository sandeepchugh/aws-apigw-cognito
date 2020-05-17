

# Healthcheck
# resource /healthcheck GET

resource "aws_api_gateway_resource" "healthcheck_apigateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  parent_id   = aws_api_gateway_rest_api.apigateway.root_resource_id
  path_part   = "healthcheck"
}

resource "aws_api_gateway_method" "healthcheck_get" {
  rest_api_id      = aws_api_gateway_rest_api.apigateway.id
  resource_id      = aws_api_gateway_resource.healthcheck_apigateway_resource.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = "false"
}

resource "aws_api_gateway_integration" "healthcheck_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_resource.healthcheck_apigateway_resource.id
  http_method = aws_api_gateway_method.healthcheck_get.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = <<EOF
{"statusCode":200}
EOF
  }
}

resource "aws_api_gateway_method_response" "healthcheck_get_response_200" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_resource.healthcheck_apigateway_resource.id
  http_method = aws_api_gateway_method.healthcheck_get.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "healthcheck_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  resource_id = aws_api_gateway_resource.healthcheck_apigateway_resource.id
  http_method = aws_api_gateway_method.healthcheck_get.http_method
  status_code = aws_api_gateway_method_response.healthcheck_get_response_200.status_code

  response_templates = {
    "application/json" = <<EOF
{"alive":"true"}
EOF
  }
}
