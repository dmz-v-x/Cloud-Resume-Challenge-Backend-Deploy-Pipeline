output "api_gateway_arn" {
  description = "ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.api.arn
}

output "api_invoke_url" {
  description = "API Gateway invocation URL"
  value       = "${aws_api_gateway_stage.api_stage.invoke_url}/counter"
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.my_table.arn
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.lambda_function.arn
}
