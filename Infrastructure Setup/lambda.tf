resource "aws_lambda_function" "lambda_function" {
  function_name    = "visitor-counter-function"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "python3.13"
  filename         = "../visitor-counter-function-2c0c9c3a-588b-4395-9e5b-d00363211ba5.zip"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("../visitor-counter-function-2c0c9c3a-588b-4395-9e5b-d00363211ba5.zip")
}
