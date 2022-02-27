

resource "aws_lambda_permission" "api-gateway-invoke-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend.function_name
  principal     = "apigateway.amazonaws.com"

}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_backend"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "lambda_role" {
  name = "role_for_backend"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*",
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

data "archive_file" "backend_source" {
  type        = "zip"
  source_file = "./backendCodeBase/main.py"
  output_path = "./backendCodeBase/backend.zip"
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "backendbucket-${random_string.suffix.result}"
}

resource "aws_s3_object" "backend_upload" {
  bucket = aws_s3_bucket.backend_bucket.bucket
  key    = "backend.zip"
  source = data.archive_file.backend_source.output_path
}

resource "aws_lambda_function" "backend" {
  s3_bucket     = aws_s3_bucket.backend_bucket.bucket
  s3_key        = aws_s3_object.backend_upload.key
  function_name = "lambda_backend"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.lambda_handler"

  source_code_hash = filebase64sha256(data.archive_file.backend_source.output_path)

  runtime = "python3.9"
}
