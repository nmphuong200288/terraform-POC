provider "aws" {
  region = "ap-southeast-2"
}

module "rds" {
  source = "./modules/rds"

  mysql                  = var.mysql
  db_password            = var.db_password  
  db_username            = var.db_username
  subnet_ids             = data.terraform_remote_state.vpc.outputs.private_subnet
  vpc_security_group_ids = data.terraform_remote_state.sg.outputs.db_sg_id
}

