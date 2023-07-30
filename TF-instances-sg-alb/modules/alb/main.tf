#Create target group
resource "aws_lb_target_group" "target-group" {
    health_check {
        interval             = 10
        path                 = "/"
        protocol             = "HTTP"
        timeout              = 5
        healthy_threshold    = 5
        unhealthy_threshold  = 2
    }

     name          = var.target_group_name
     port          = 80
     protocol      = "HTTP"
     target_type   = "instance"
     vpc_id        = var.vpc_id

}

#Create ALB
resource "aws_lb" "application-lb" {
    name               = var.loadbalancer_name
    internal           = false
    ip_address_type    = "ipv4"
    load_balancer_type = "application"
    # security_groups    = [aws_security_group.web-server.id]
    security_groups    = var.security_groups
    subnets            = var.subnets

    tags  = {
        Name = "${var.tags_name["my_alb_name"]}"
    }
}
#Create listener
resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn  = aws_lb.application-lb.arn
    port               = 80
    protocol           = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.target-group.arn
      type             = "forward"
    }
}

#Attachment
# resource "aws_lb_target_group_attachment" "ec2_attach" {
#     count              = length(aws_instance.web-server)
#     target_group_arn   = aws_lb_target_group.target-group.arn
#     target_id          = aws_instance.web-server[count.index].id
# }

resource "aws_lb_target_group_attachment" "ec2_attach" {
    count              = 2
    target_group_arn   = aws_lb_target_group.target-group.arn
    # target_id          = "${element(var.instance_id, count.index)}"
    target_id          = var.instance_id[count.index]
    port               = 80
}

