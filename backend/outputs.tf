output "lambda_arn" {
    description = "ARN of the lambda function"
    value = aws_lambda_function.backend.arn
}

output "lambda_invoke_arn" {
  description = "Invoke URI of the lambda function"
    value = aws_lambda_function.backend.invoke_arn
}