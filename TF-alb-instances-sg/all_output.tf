# All output of instances
output "instance_public_ip" {
  value = module.instances.instance_public_ip
}
output "instance_public_dns" {
  value = module.instances.instance_public_dns
}
output "instance_primary_network_interface_id" {
  value = module.instances.instance_primary_network_interface_id
}
output "instance_arn" {
  value = module.instances.instance_arn
}
output "instance_id" {
  value = module.instances.instance_id
}

# All output of alb
output "elb-dns-name" {
    value        = module.alb.elb-dns-name
}

# All output of Security Group of EC2
output "ec2_sg_id" {
  value = module.sg_ec2.ec2_sg_id
}

# All output of Security Group of DB
output "db_sg_id" {
  value = module.sg_db.db_sg_id
}
