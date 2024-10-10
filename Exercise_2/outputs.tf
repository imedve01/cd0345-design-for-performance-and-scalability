# TODO: Define the output variable for the lambda function.
# Output the Lambda Function Name
output "lambda_function_name" {
  value       = aws_lambda_function.my_lambda.function_name
}
