data "aws_iam_policy_document" "example_lambda_policy" {
	statement {
		sid    = "examplePolicyId"
		effect = "Allow"
		principals {
			identifiers = ["lambda.amazonaws.com"]
			type        = "Service"
		}
		actions = ["sts:AssumeRole"]
	}
}

