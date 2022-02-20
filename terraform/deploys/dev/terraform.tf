// Backend, Provider etc.

terraform {

  backend "s3" {
    bucket = "2dd3dgww-terraform-us-east-1"
    key    = "gitops-progressive-deployments-dev"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
