#Creating RDS Instance Subnet Group
resource "aws_db_subnet_group" "ecs_rds" {
  name       = "ecs_rds"
  subnet_ids = [aws_subnet.subnet_private1.id, aws_subnet.subnet_private2.id]

  tags = {
    Name = var.rds_subnet_name
    Environment = var.environment_name
  }
}

#Creating RDS Progres Instance
resource "aws_db_instance" "rds_instance" {
  db_subnet_group_name   = aws_db_subnet_group.ecs_rds.id
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.rds_engine
  engine_version       = var.rds_engineversion
  instance_class       = var.rds_instanceclass #for dev/test environment
  username             = var.rds_username
  password             = var.rds_password
  port                 = var.postgres_db_port
  storage_type         = var.storage_type
  network_type         = var.network_type
  skip_final_snapshot  = true
  vpc_security_group_ids    = [aws_security_group.rds-sec.id]
  multi_az             = false #for dev/test environment using free tier
  
  tags = {
    Name = var.rds_name
    Environment = var.environment_name
  }
}
