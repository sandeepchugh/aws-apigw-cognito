variable "env_suffix" {}
variable "env_name" {}
variable "log_level" {}
variable "dynamodb_read_capacity"{}
variable "dynamodb_write_capacity" {}
variable "user_pool_name" {}
variable "read_scope" {}
variable "write_scope" {}
variable "delete_scope" {}
variable "user_pool_profileapi_client" {}
variable "profile_api_url" {}
variable "api_scopes" {
    type = "map"
    default = {
      read_scope = {
        "scope_name": "read"
        "scope_description": "read permission"
      },
      write_scope = {
        "scope_name": "write"
        "scope_description": "write permission"
      },
      delete_scope = {
        "scope_name": "delete",
        "scope_description": "delete permission"
      }
    }
  }