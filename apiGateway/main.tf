resource "aws_api_gateway_rest_api" "rest_api" {
  name           = "textReplaceAPI"
  description    = "API to perform text replacements"
  api_key_source = "HEADER"
  body           = templatefile("./apiGateway/spec.yml", {lambda_arn = "${var.lambda_arn}"})
  

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
