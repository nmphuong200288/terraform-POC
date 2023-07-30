output "vpc" { 
  value = aws_vpc.vpc.id
  }

output "public_subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet" {
  value = aws_subnet.private_subnet[*].id
}

output "ElasticIP" {
    value = aws_eip.elasticeip.public_ip
}

output "aws_account_id" {
    value = aws_subnet.public_subnet[0].owner_id
}

output "public_subnet_arn" {
    value = aws_subnet.public_subnet[*].arn
}