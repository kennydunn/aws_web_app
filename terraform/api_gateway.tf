resource "aws_api_gateway_rest_api" "HelloWorldAPI" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "HelloWorldAPI"
      version = "1.0"
    }
    paths = {
      "/" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "LAMBDA"

          }
        }
      }
    }
  })

  name = "example"
}