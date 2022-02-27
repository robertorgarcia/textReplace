resource "aws_api_gateway_rest_api" "rest_api" {
  name           = "textReplaceAPI"
  description    = "API to perform text replacements"
  api_key_source = "HEADER"
  body           = templatefile("./apiGateway/spec.yml", {lambda_arn = "${var.lambda_arn}"})
  

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "rest_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.rest_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "rest_stage" {
  deployment_id = aws_api_gateway_deployment.rest_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = "prod"
}