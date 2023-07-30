output "instance_public_ip" {
  value = aws_instance.web-server[*].public_ip
}

output "instance_public_dns" {
  value = aws_instance.web-server[*].public_dns
}

output "instance_primary_network_interface_id" {
  value = aws_instance.web-server[*].primary_network_interface_id
}

output "instance_arn" {
  value = aws_instance.web-server[*].arn
}

output "instance_id" {
  value = aws_instance.web-server[*].id
}
