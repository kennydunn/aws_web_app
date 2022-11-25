output "example_function" {
	value = aws_lambda_function.example_lambda_function.qualified_arn
}
output "lambda_function" {
	value = aws_lambda_function.lambda_function_lambda_function.qualified_arn
}
output "dynamo_arn" {
	value = aws_dynamodb_table.HelloWorldDatabase.arn
}


output "dev_url" {
  value = "https://${aws_api_gateway_deployment.HelloWorldAPI_deployment_dev.rest_api_id}.execute-api.${var.aws_region}.amazonaws.com/${aws_api_gateway_deployment.HelloWorldAPI_deployment_dev.stage_name}"
}