provider "aws" {
  region = "ap-southeast-2"
}

module "vpc" {
  # source = "./modules/networking/vpc"
  source = "git::https://github.com/nmphuong200288/terraform-POC.git//TF-infrastructure"

  project           = var.project
  region            = var.region
  vpc_cidr_block    = var.vpc_cidr_block
  private_subnet    = var.private_subnet
  public_subnet     = var.public_subnet
  rds_subnet        = var.rds_subnet
  availability_zone = var.availability_zone
  tags_name         = var.tags_name
}


   
