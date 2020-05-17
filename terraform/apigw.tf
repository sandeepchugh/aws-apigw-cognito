# api
resource "aws_api_gateway_rest_api" "apigateway" {
  name        = "${local.project_name}-api${var.env_suffix}"
  description = "${local.project_description} Api Gateway"
}

# deployment
resource "aws_api_gateway_deployment" "apigateway_deployment" {
  # https://stackoverflow.com/questions/42760387/terraform-aws-api-gateway-dependency-conundrum/42783769#42783769
  depends_on = [
    aws_api_gateway_rest_api.apigateway,
    aws_api_gateway_integration.healthcheck_get_integration,
    aws_api_gateway_integration.profile_get_integration,
    aws_api_gateway_integration.profile_post_integration,
    aws_api_gateway_integration.profile_put_integration,
    aws_api_gateway_method.profile_apigateway_get,
    aws_api_gateway_method.profile_apigateway_post,
    aws_api_gateway_method.profile_apigateway_put
  ]

  rest_api_id = aws_api_gateway_rest_api.apigateway.id
  stage_name  = var.env_name

  lifecycle{
    create_before_destroy = true
  }
}


# domain
data "aws_acm_certificate" "cert" {
  statuses = ["ISSUED"]
  provider = aws
  domain = "*.${local.domain_name}"
}

resource "aws_api_gateway_domain_name" "profile" {
  domain_name       = local.api_domain
  certificate_arn   = data.aws_acm_certificate.cert.arn
}

resource "aws_api_gateway_base_path_mapping" "profile" {
  api_id      = aws_api_gateway_rest_api.apigateway.id
  stage_name  = aws_api_gateway_deployment.apigateway_deployment.stage_name
  domain_name = aws_api_gateway_domain_name.profile.domain_name
}

resource "aws_route53_record" "profile" {
  zone_id = local.zone_id

  name = aws_api_gateway_domain_name.profile.domain_name
  type = "A"

  alias {
    name                   = aws_api_gateway_domain_name.profile.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.profile.cloudfront_zone_id
    evaluate_target_health = true
  }
}

# usage plan
resource "aws_api_gateway_usage_plan" "apigateway_usage_plan" {
  name = "${local.project_name}-apigateway-usage-plan${var.env_suffix}"
  throttle_settings {
    burst_limit = 5
    rate_limit = 10
  }

  quota_settings {
    limit = 1000
    period = "MONTH"
  }

  api_stages {
    api_id = aws_api_gateway_rest_api.apigateway.id
    stage  = aws_api_gateway_deployment.apigateway_deployment.stage_name
  }
}

# logs
resource "aws_cloudwatch_log_group" "apigateway_log_group" {
  name              = "${local.log_group_name}/apigw${var.env_suffix}"
  retention_in_days = "7"
}

resource "aws_cloudwatch_log_stream" "apigateway_log_stream" {
  name           = "${local.project_name}-api-apigw${var.env_suffix}"
  log_group_name = aws_cloudwatch_log_group.apigateway_log_group.name
}