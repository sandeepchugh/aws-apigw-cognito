resource "aws_dynamodb_table" "profile_table" {
  name           = "${local.project_name}-table${var.env_suffix}"
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  hash_key       = local.dynamodb_hash_key
  range_key       = local.dynamodb_sort_key

  attribute {
    name = local.dynamodb_hash_key
    type = "S"
  }

   attribute {
    name = local.dynamodb_sort_key
    type = "S"
  }


  tags = {
    Name        = "${local.project_name}-table${var.env_suffix}"
    Environment = var.env_name
    Application = local.application_name
  }
}