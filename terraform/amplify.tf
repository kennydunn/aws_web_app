resource "aws_amplify_app" "htmlWebApp" {
  name       = "htmlWebApp"
  repository = "https://github.com/kennydunn/webapp"


  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    ENV = "test"
  }
}