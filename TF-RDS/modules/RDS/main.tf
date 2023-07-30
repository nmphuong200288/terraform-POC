# Create parameter group
resource "aws_db_parameter_group" "dbparameter" {
  name   = "rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

#Create Subnet group
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "remotestate-backend-s3"
    key     = "minhphuong/vpc.tfstate"
    region  = "ap-southeast-2"
  }
}
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = var.subnet_ids
  # subnet_ids = data.aws_subnet.private_subnet.id

  tags = {
    Name = "db_subnet"
  }
}

# Create Database instance
resource "aws_db_instance" "database" {
  identifier             = "${var.mysql}"
  instance_class         = "db.t2.micro"
  allocated_storage      = 10
  apply_immediately      = true
  backup_retention_period = 1
  engine                 = "mysql"
  engine_version         = "8.0.32"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  parameter_group_name   = aws_db_parameter_group.dbparameter.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

#Create Relicas instance
resource "aws_db_instance" "database_replica" {
   identifier             = "${var.mysql}-replica"
   replicate_source_db    = aws_db_instance.database.identifier
   instance_class         = "db.t2.micro"
   apply_immediately      = true
   publicly_accessible    = true
   skip_final_snapshot    = true
   vpc_security_group_ids = [var.vpc_security_group_ids]
   parameter_group_name   = aws_db_parameter_group.dbparameter.name
}