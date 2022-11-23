resource "aws_dynamodb_table" "HelloWorldDatabase" {
  name           = "HelloWorldDatabase"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key       = "ID"
  attribute {
    name = "ID"
    type = "S"
  }
}