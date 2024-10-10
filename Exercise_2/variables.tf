# TODO: Define the variable for aws_region

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function to be created"
  type        = string
  default     = "MySimpleLambdaFunction"
}
