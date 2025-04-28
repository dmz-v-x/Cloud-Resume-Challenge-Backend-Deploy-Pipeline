resource "aws_dynamodb_table" "my_table" {
  name           = "visitor-counter"
  hash_key       = "id"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 0
  write_capacity = 0

  attribute {
    name = "id"
    type = "S"
  }
}