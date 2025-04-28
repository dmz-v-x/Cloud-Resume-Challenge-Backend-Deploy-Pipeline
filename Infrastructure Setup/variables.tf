variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
  default     = "prod"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "visitor-counter"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "visitor-counter-table"
}
