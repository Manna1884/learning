#Creating Internet Facing ALB
resource "aws_lb" "alb" {
  internal = "false"
  name = var.alb_name
  load_balancer_type = var.loadbalancer_type
  subnets = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]
  security_groups = [aws_security_group.external-alb-sec.id]
  enable_deletion_protection = "false"
    
tags = { 
   Environment = var.environment_name
  }
}



#Creating Load Balancer Listener for http
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target.arn
  }

  tags = { 
   Environment = var.environment_name
  }

}


#Creating Target Group
resource "aws_lb_target_group" "ip_target" {
  name        = var.target_group_name
  port        = var.http_port
  protocol    = "HTTP"
  target_type = var.target_type
  vpc_id      = aws_vpc.ecs_project.id

health_check {
        enabled             = true
        interval            = 30
        path                = var.healthcheck_path
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }      
 tags = {  # Target Group Tags
  Environment = var.environment_name
      }
}
