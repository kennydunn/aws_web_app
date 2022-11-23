data "archive_file" "lambda_function_zip_file" {
	type        = "zip"
	source_file = "lambda_function.py"
	output_path = "lambda_function.zip"
}

resource "aws_iam_role" "lambda_function_lambda_iam" {
	name               = "lambda_function_lambda_iam"
	assume_role_policy = data.aws_iam_policy_document.example_lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_execution_policy" {
  role       = aws_iam_role.lambda_function_lambda_iam.name
  policy_arn = aws_iam_policy.lambda_function_execution_policy.arn
}

resource  "aws_iam_policy" "lambda_function_execution_policy" {
  name        = "lambda_function_execution_policy"
  description = "lambda_function_execution_policy"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ]
        Resource = "arn:aws:dynamodb:eu-west-1:051302534991:table/HelloWorldDatabase"
      },
    ]
  })
}



resource "aws_lambda_function" "lambda_function_lambda_function" {
	function_name    = "lambda_function"
	filename          = data.archive_file.lambda_function_zip_file.output_path
	# source_code_hash = data.archive_file.exmaple_file_zip.output_base64sha256
	role             = aws_iam_role.lambda_function_lambda_iam.arn
	handler          = "lambda_function.lambda_handler"
	runtime          = "python3.9"
}