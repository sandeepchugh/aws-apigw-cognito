

#output

output "base_url" {
  value = aws_api_gateway_deployment.apigateway_deployment.invoke_url
}

