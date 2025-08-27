terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
    
  }
  backend "s3" {
    bucket = "jadav-bucket-terraform-12345"
    key = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "my_table"
    
  }
}

provider "aws" {
    region = "eu-west-1"
}