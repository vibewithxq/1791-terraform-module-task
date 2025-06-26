provider "aws" {
  region = var.region
}

terraform {
  required_version = ">=1.0.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}