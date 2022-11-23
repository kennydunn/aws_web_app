provider "archive" {}
data "archive_file" "example_zip_file" {
	type        = "zip"
	source_file = "example.py"
	output_path = "example.zip"
}

resource "aws_iam_role" "example_lambda_iam" {
	name               = "example_lambda_iam"
	assume_role_policy = data.aws_iam_policy_document.example_lambda_policy.json
}

resource "aws_lambda_function" "example_lambda_function" {
	function_name    = "example_function"
	filename          = data.archive_file.example_zip_file.output_path
	# source_code_hash = data.archive_file.exmaple_file_zip.output_base64sha256
	role             = aws_iam_role.example_lambda_iam.arn
	handler          = "example.lambda_handler"
	runtime          = "python3.9"
}