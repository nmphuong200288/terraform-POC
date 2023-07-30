tags_name                   = {
    my_environment          = "Prod",
    my_server_web           = "r1-poc-web"
    my_alb_name             = "phuong-alb"
    security_group_ec2      = "EC2 security",
    security_group_db_name  = "database security",
  }
  
instance_type ="t2.micro"
loadbalancer_name    = "phuong-alb"
target_group_name    = "phuong-tg"
