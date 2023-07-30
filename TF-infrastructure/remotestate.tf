terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "remotestate-backend-s3"
    key     = "minhphuong/vpc.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
    profile = "default"

  }
}
