resource "aws_iam_role" "lambda_execution_role" {
  name        = "LambdaRole"
  description = "Allows Lambda functions to call AWS services on your behalf."
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_policy" {
  name = "dynamodb-policy"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "dynamodb:UpdateItem",
            "dynamodb:GetItem",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:dynamodb:ap-south-1:590183681939:table/visitor-counter"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

# Attach AWS managed policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Attach your custom DynamoDB policy
resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

