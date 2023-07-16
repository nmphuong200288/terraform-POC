output "public_subnet" {
  value = module.vpc.public_subnet
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "vpc_id" { 
  value = module.vpc.vpc
  }

output "ElasticIP" {
    value = module.vpc.ElasticIP
}

output "aws_account_id" {
    value = module.vpc.aws_account_id
}

output "public_subnet_arn" {
    value = module.vpc.public_subnet_arn
}
# output "public_security_group" {
#   value = module.networking.public_security.id
# }

# output "private_security_group" {
#   value = module.networking.private_security.id
# }