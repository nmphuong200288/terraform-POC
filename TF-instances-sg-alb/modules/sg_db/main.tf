# Create Public_Security_Group 
resource "aws_security_group" "rds" {
  name = "SG_rds"
  description = "Allow incoming Connection of database"
  vpc_id = var.vpc_id
# Allow Open Port 3306
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Allow ICMP to database
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


# Allow all traffic from inside to outside
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.tags_name["security_group_db_name"]}"
    }
}