resource "aws_cognito_user_pool" "pool" {
  name = var.user_pool_name
  auto_verified_attributes = ["email"]
}


# https://github.com/terraform-providers/terraform-provider-aws/issues/10159
resource "aws_cognito_resource_server" "profile_resource" {
  identifier = "https://profileapi${var.env_suffix}.sandeepchugh.net"
  name       = "profileapi"

  dynamic "scope" {
      for_each = [for key, value in var.api_scopes: {
        scope_name     = value.scope_name
        scope_description     = value.scope_description
      }]

      content {
        scope_name     = scope.value.scope_name
        scope_description = scope.value.scope_description
      }
    }

  user_pool_id = aws_cognito_user_pool.pool.id
}


resource "aws_cognito_user_pool_client" "app_client" {
    name = var.user_pool_profileapi_client
    user_pool_id = aws_cognito_user_pool.pool.id
    generate_secret = false
    allowed_oauth_scopes = ["${var.profile_api_url}/read",
                            "${var.profile_api_url}/write",
                            "${var.profile_api_url}/delete"
    ]
    callback_urls = [var.profile_api_url]
    supported_identity_providers = ["COGNITO"]
    allowed_oauth_flows = ["implicit"]
    allowed_oauth_flows_user_pool_client = true
}