locals {
  project_name = "profile"
  project_description = "Instiguide User Profile"
  domain_name = "sandeepchugh.net"
  api_domain = "${local.project_name}api${var.env_suffix}.sandeepchugh.net"
  application_name  = "${local.project_name}-api"
  log_group_name = "/instiguide/api/profile"
  lambda_file_name = "${local.application_name}.zip"
  lambda_timeout = "30"
  lambda_memory = "512"
  lambda_runtime = "python3.7"
  dynamodb_hash_key = "user_id"
  dynamodb_sort_key = "org_id"
  lambda_function_name = "src.lambda_function.function_handler"
  zone_id = var.zone_id
}