# Create security_Group 
resource "aws_security_group" "ec2" {
  name = "SG_HTTP"
  description = "Allow HTTP incoming Connection"
  vpc_id = var.vpc_id
# Allow Open HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ssh Input"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
#Allow ICMP
egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    "Name" = "${var.tags_name["security_group_ec2"]}"
    }
}