data "archive_file" "get_dynamodb_data_zip_file" {
	type        = "zip"
	source_file = "get_dynamodb_data.py"
	output_path = "get_dynamodb_data.zip"
}


resource "aws_lambda_function" "get_dynamodb_data_function_lambda_function" {
	function_name    = "get_dynamodb_data_function"
	filename          = data.archive_file.get_dynamodb_data_zip_file.output_path
	role             = aws_iam_role.lambda_function_lambda_iam.arn
	handler          = "get_dynamodb_data.lambda_handler"
	runtime          = "python3.9"
}