variable "tags_name" {
  type = map(string)
}
variable "instance_type" {
  type    = string
}
variable "subnet_id" {
  type     = list(string)
} 

variable "security_groups" {
  type = list(string)
}



