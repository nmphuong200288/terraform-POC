
# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.tags_name["myvpc"]}"
    "Project" = "${var.project}"
  }
}
# Create a sub-net private.
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet)
  # count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
  # availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "${var.tags_name["my_private_subnet"]}-${count.index + 3}"
  }
}

# Create a sub-net public.
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet)
  # count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet[count.index]
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
  # availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "${var.tags_name["my_public_subnet"]}-${count.index + 1}"
  }
}

resource "aws_subnet" "rds_subnet" {
  count = length(var.rds_subnet)
  # count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.rds_subnet[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
  # availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "${var.tags_name["my_rds_subnet"]}-${count.index + 5}"
  }
}


# Create an internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.tags_name["my_internet_gateway"]}"
  }
}

# Assign IG for public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    "Name" = "${var.tags_name["my_public_route_table"]}"
  }
}


# Assign Nat gateway for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "${var.tags_name["my_private_route_table"]}"
  }
}

# Assign Nat gateway for rds subnets
resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "${var.tags_name["my_rds_route_table"]}"
  }
}
# Assign route table for public subnets
# Biến v sẽ chạy qua lần lượt các phần tử trong aws_subnet.public_subnet
# sau đó nó sẽ lấy giá trị và gán cho biến "k"

resource "aws_route_table_association" "public_association" {
  for_each       = { 
    for k, v in aws_subnet.public_subnet : k =>v 
    }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Assign route table for private subnets

 resource "aws_route_table_association" "private_association" {
   for_each       = { 
    for k, v in aws_subnet.private_subnet : k => v 
    }
   subnet_id      = each.value.id
   route_table_id = aws_route_table.private.id
 }
# Assign route table for rds subnets
resource "aws_route_table_association" "rds_association" {
   for_each       = { 
    for k, v in aws_subnet.rds_subnet : k => v 
    }
   subnet_id      = each.value.id
   route_table_id = aws_route_table.private.id
 }

# Create NAT gateway
resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.elasticeip.id
  subnet_id     = aws_subnet.public_subnet[0].id
    
  tags = {
    "Name" = "${var.tags_name["my_nat_gateway"]}"
  }
  depends_on = [aws_internet_gateway.ig]
}

#Enable EIP
resource "aws_eip" "elasticeip" {
  # vpc      = true
  domain     = "vpc"
}

