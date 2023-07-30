variable "tags_name" {
  type = map(string)
}
variable "loadbalancer_name" {
  type    = string
}
variable "target_group_name" {
  type     = string
} 
variable "vpc_id" {
  type     = string
} 
variable "subnets" {
  type     = list(string)
} 

variable "instance_id" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}
