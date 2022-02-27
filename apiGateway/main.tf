resource "aws_api_gateway_rest_api" "rest_api" {
  name           = "textReplaceAPI"
  description    = "API to perform text replacements"
  api_key_source = "HEADER"
  body           = data.template_file.open_api_spec.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

data "template_file" "open_api_spec" {
  template = "./spec.yaml"

  vars = {
    lambda_arn          = var.lambda_arn
  }

}