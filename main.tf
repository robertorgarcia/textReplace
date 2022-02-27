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

module "api_gateway"{
  source = "./apiGateway"
}