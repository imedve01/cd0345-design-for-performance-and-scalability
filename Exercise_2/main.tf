# main.tf

provider "aws" {
  region = var.aws_region
}

# Create an IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to allow Lambda to write to CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Zip the Lambda Function
resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    command = "zip lambda.zip lambda.py"
  }

  triggers = {
    always_run = timestamp()
  }
}

# Create the Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.8"
  filename         = "${path.module}/lambda.zip"  # Path to the zipped Lambda function
  source_code_hash = filebase64sha256("lambda.zip")

  depends_on = [null_resource.zip_lambda]
}
