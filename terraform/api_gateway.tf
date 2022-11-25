resource "aws_api_gateway_rest_api" "HelloWorldAPI" {
  description = "Helloworld Rest Api"
  name = "getdynamodbdata"
}

resource "aws_api_gateway_resource" "HelloWorldAPI_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.HelloWorldAPI.id}"
  parent_id = "${aws_api_gateway_rest_api.HelloWorldAPI.root_resource_id}"
  path_part = "messages"
}
resource "aws_api_gateway_method" "HelloWorldAPI_method" {
  rest_api_id = "${aws_api_gateway_rest_api.HelloWorldAPI.id}"
  resource_id = "${aws_api_gateway_resource.HelloWorldAPI_resource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "HelloWorldAPI_method-integration" {
  rest_api_id = "${aws_api_gateway_rest_api.HelloWorldAPI.id}"
  resource_id = "${aws_api_gateway_resource.HelloWorldAPI_resource.id}"
  http_method = "${aws_api_gateway_method.HelloWorldAPI_method.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.aws_region}:${var.account_id}:function:${aws_lambda_function.get_dynamodb_data_function_lambda_function.function_name}/invocations"
  integration_http_method = "GET"
}

resource "aws_api_gateway_deployment" "HelloWorldAPI_deployment_dev" {
  depends_on = [
    "aws_api_gateway_method.HelloWorldAPI_method",
    "aws_api_gateway_integration.HelloWorldAPI_method-integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.HelloWorldAPI.id}"
  stage_name = "dev"
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.HelloWorldAPI.id
  resource_id = aws_api_gateway_resource.HelloWorldAPI_resource.id
  http_method = aws_api_gateway_method.HelloWorldAPI_method.http_method
  status_code = "200"
}