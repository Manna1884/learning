#Security Group for Internet Facing ALB
resource "aws_security_group" "external-alb-sec" {
  description = "Allow ALB inbound traffic"
  vpc_id      = aws_vpc.ecs_project.id

  ingress {
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.external_alb_sec_name
    Environment = var.environment_name
  }
}

#Security Group for ECS Containers
resource "aws_security_group" "ecs-sec" {
  description = "Allow Internal-ALB inbound traffic from only External-ALB"
  vpc_id      = aws_vpc.ecs_project.id

  ingress {
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.external-alb-sec.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.internal_alb_sec_name
    Environment = var.environment_name
  }
}

#Security Group for RDS
resource "aws_security_group" "rds-sec" {
  description = "Allow RDS inbound traffic from only ECS Container"
  vpc_id      = aws_vpc.ecs_project.id

  ingress {
    from_port        = var.postgres_db_port
    to_port          = var.postgres_db_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.ecs-sec.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sec_name
    Environment = var.environment_name
  }
}