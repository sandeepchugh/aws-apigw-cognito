provider "aws" {
  region = "us-east-1"
  profile = "default"
}

data "aws_region" "region" {}

data "aws_caller_identity" "current" {}
