variable "mysql" {
  type    = string
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  # sensitive   = true
}

variable "db_username" {
  description = "RDS root user"
  type        = string
  # sensitive   = true
}

variable "subnet_ids" {
  description = "ID of subnet for database"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "ID of security group for database"
  type        = string
}









