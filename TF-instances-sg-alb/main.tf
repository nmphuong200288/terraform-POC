provider "aws" {
  region = "ap-southeast-2"
}
#===========Instance module===========
module "instances" {
  # source = "./modules/instances"
  source   = "git::https://github.com/nmphuong200288/terraform-POC.git//TF-infrastructure"
  tags_name            = var.tags_name
  instance_type        = var.instance_type
  subnet_id            = data.terraform_remote_state.vpc.outputs.public_subnet
  security_groups      = [module.sg_ec2.ec2_sg_id]
}

#=========Security Group EC2Module=======
module "sg_ec2" {
  # source = "./modules/sg_ec2"
  source   = "git::https://github.com/nmphuong200288/terraform-POC.git//TF-infrastructure"

  tags_name         = var.tags_name
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
}

#=========Security Group DBModule=======
module "sg_db" {
  # source = "./modules/sg_db"
  source   = "git::https://github.com/nmphuong200288/terraform-POC.git//TF-infrastructure"

  tags_name         = var.tags_name
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
}

#==============ALB module==============
module "alb" {
  # source = "./modules/alb"
  source   = "git::https://github.com/nmphuong200288/terraform-POC.git//TF-infrastructure"

tags_name            = var.tags_name
loadbalancer_name    = var.loadbalancer_name
target_group_name    = var.target_group_name
vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
subnets              = data.terraform_remote_state.vpc.outputs.public_subnet 
instance_id          = module.instances.instance_id
security_groups      = [module.sg_ec2.ec2_sg_id]
}