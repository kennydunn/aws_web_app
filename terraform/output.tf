output "example_function" {
	value = aws_lambda_function.example_lambda_function.qualified_arn
}
output "lambda_function" {
	value = aws_lambda_function.lambda_function_lambda_function.qualified_arn
}
output "dynamo_arn" {
	value = aws_dynamodb_table.HelloWorldDatabase.arn
}