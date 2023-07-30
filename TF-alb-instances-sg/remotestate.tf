terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "remotestate-backend-s3"
    key     = "minhphuong/ins-sg-alb.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
    profile = "default"

  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "remotestate-backend-s3"
    key     = "minhphuong/vpc.tfstate"
    region  = "ap-southeast-2"
  }
}