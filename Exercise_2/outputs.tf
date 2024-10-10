# TODO: Define the output variable for the lambda function.

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.my_lambda.arn
}

# Output the Lambda Function Name
output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.my_lambda.function_name
}
