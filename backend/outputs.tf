output "lambda_arn" {
    description = "ARN of the lambda function"
    value = aws_lambda_function.backend.arn
}