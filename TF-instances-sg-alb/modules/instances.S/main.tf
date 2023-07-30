
#Create WEB_EC2 belong to private subnet
data "aws_ami" "ubuntu_web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230112"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web-server" {
  # count           = length(local.subnets_public)
  count           = length(var.subnet_id)
  ami             = data.aws_ami.ubuntu_web.id
  instance_type   = var.instance_type
  # subnet_id       = aws_subnet.public_subnet[0].id
  # subnet_id       = element(local.subnets_public, count.index)
  subnet_id       = var.subnet_id[count.index]
  security_groups = var.security_groups
  key_name        = "jenkin-ssh"
  # user_data = "${file("${path.module}/wordpress.sh")}"
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y &&
  sudo apt install -y nginx
  echo "WELCOME TO IMS TEAM AND HOSTNAME IS: $(hostname -f)" > /var/www/html/index.html
  EOF
  # root disk
  root_block_device {
    volume_size               = "8"
    volume_type               = "gp2"
    encrypted                 = false
    delete_on_termination     = true
  }

  tags = {
    "Name"                      = "${var.tags_name["my_server_web"]}${count.index + 1}"
    "Environment"               = "${var.tags_name["my_environment"]}"
  }
}
