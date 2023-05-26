terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.1"
    }
  }
  backend "s3" {
    bucket         = "terraform-statefile-nextjs-project-0008"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }

}

provider "aws" {
  region = var.region
}