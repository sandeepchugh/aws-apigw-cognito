resource "aws_lambda_function" "profile_lambda" {
  function_name    = "${local.project_name}-lambda${var.env_suffix}"
  handler          = local.lambda_function_name
  role             = aws_iam_role.api_lambda_role.arn
  runtime          = local.lambda_runtime
  memory_size      = local.lambda_memory
  timeout          = local.lambda_timeout
  filename         = local.lambda_file_name
  source_code_hash = filebase64sha256(local.lambda_file_name)

  environment {
    variables = {
      LogLevel = var.log_level
      Region   = data.aws_region.region.name
      TableName= aws_dynamodb_table.profile_table.name
    }
  }

  tags = {
    Name        = "${local.project_name}-lambda${var.env_suffix}"
    Environment = var.env_name
    Application = local.application_name
  }
}

resource "aws_lambda_permission" "profile_apigateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.profile_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.apigateway.execution_arn}/*/*"
}

resource "aws_lambda_permission" "profile_lambda_cloudwatch_permission" {
  statement_id  = "AllowCloudwatchInvoke${local.application_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.profile_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn = "arn:aws:events:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:/*/*"
}

resource "aws_cloudwatch_log_group" "profile_lambda_log_group" {
  name              = "${local.log_group_name}/lambda${var.env_suffix}"
  retention_in_days = "7"
}

resource "aws_cloudwatch_log_stream" "profile_lambda_log_stream" {
  name           = "${local.project_name}-api-lambda{var.env_suffix}"
  log_group_name = aws_cloudwatch_log_group.profile_lambda_log_group.name
}