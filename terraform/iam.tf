resource "aws_iam_role" "profile_api_gateway_role" {
  name = "${local.project_name}-api-gateway-role${var.env_suffix}"

  assume_role_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Effect":"Allow",
            "Principal":{
                "Service":[
                    "apigateway.amazonaws.com"
                ]
            },
            "Action":"sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "products_api_gateway_policy" {
  name = "${local.project_name}-api-gateway-policy${var.env_suffix}"
  role = aws_iam_role.profile_api_gateway_role.id
  policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Effect":"Allow",
            "Action":"*",
            "Resource": "${aws_lambda_function.profile_lambda.arn}"
        },
        {
            "Effect":"Allow",
            "Action":"execute-api:Invoke",
            "Resource": "arn:aws:execute-api::*:*:*"
        },
        {
            "Effect":"Allow",
            "Action":[
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:DescribeLogStreams"
            ],
            "Resource": "${aws_cloudwatch_log_stream.apigateway_log_stream.arn}"
        },
        {
            "Effect":"Allow",
            "Action":"lambda:InvokeFunction",
            "Resource": "${aws_lambda_function.profile_lambda.arn}"
        }
    ]
}
EOF
}


resource "aws_iam_role" "api_lambda_role" {
  name = "${local.project_name}-lambda-role${var.env_suffix}"

  assume_role_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Effect":"Allow",
            "Principal":{
                "Service":[
                    "lambda.amazonaws.com"
                ]
            },
            "Action":"sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "profile_lambda_policy" {
  name = "${local.project_name}-lambda-policy${var.env_suffix}"
  role = aws_iam_role.api_lambda_role.id
  policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Effect":"Allow",
            "Action":"logs:CreateLogGroup",
            "Resource": "*"
        },
        {
            "Effect":"Allow",
            "Action":[
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": "*"
        },
        {
            "Effect":"Allow",
            "Action":[
                "dynamodb:Query",
                "dynamodb:DescribeTable",
                "dynamodb:Scan",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem",
                "dynamodb:PutItem"
            ],
            "Resource": [
                "${aws_dynamodb_table.profile_table.arn}"
            ]
        }
    ]
}
EOF
}