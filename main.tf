terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}



module "backend"{
  source = "./backend"
}

module "api_gateway"{
  source = "./apiGateway"
  lambda_arn = module.backend.lambda_arn
}