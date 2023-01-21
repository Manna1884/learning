#MAIN
variable "aws_region" {
  description = "making the aws region a variable"
  type        = string
  default     = "eu-west-2"
}

variable "environment_name" {
  description = "making the environment name a variable"
  type        = string
}

#VPC
variable "vpc_cidr" {
  description = "making the vpc cidr block a variable"
  type        = string
  default     = "200.150.0.0/16"
}
variable "vpc_default" {
  description = "making the instance tenancy a variable"
  type        = string
  default     = "default"
}

variable "dns_support" {
  description = "making the dns support a variable"
  type        = string
  default     = "true"
}

variable "dns_hostnames" {
  description = "making the dns hostnames a variable"
  type        = string
  default     = "true"
}

variable "vpc_name" {
  description = "making the vpc name a variable"
  type        = string
  default     = "ECS_Fargate"
}

#Public Subnets
variable "public1_cidr" {
  description = "making the public subnet 1 cidr block a variable"
  type        = string
  default     = "200.150.0.0/19"
}

variable "availability_zone1" {
  description = "making the available zone for public/private subnet 1 a variable"
  type        = string
  default     = "eu-west-2a"
}

variable "publicsubnet1_name" {
  description = "making the public subnet 1 name a variable"
  type        = string
  default     = "ECS-Public1"
}

variable "public2_cidr" {
  description = "making the public subnet 2 cidr block a variable"
  type        = string
  default     = "200.150.32.0/19"
}

variable "availability_zone2" {
  description = "making the available zone for public/private subnet 2 a variable"
  type        = string
  default     = "eu-west-2b"
}

variable "publicsubnet2_name" {
  description = "making the public subnet 2 name a variable"
  type        = string
  default     = "ECS-Public2"
}

#Private Subnets
variable "private1_cidr" {
  description = "making the private subnet 2 cidr block a variable"
  type        = string
  default     = "200.150.64.0/18"
}

variable "privatesubnet1_name" {
  description = "making the private subnet 1 name a variable"
  type        = string
  default     = "ECS-Private1"
}

variable "private2_cidr" {
  description = "making the private subnet 2 cidr block a variable"
  type        = string
  default     = "200.150.128.0/17"
}

variable "privatesubnet2_name" {
  description = "making the private subnet 2 name a variable"
  type        = string
  default     = "ECS-Private2"
}

#Route Tables
variable "publicroute_name" {
  description = "making the public route table name a variable"
  type        = string
  default     = "ECS-Public-Route-Table"
}

variable "privateroute_name" {
  description = "making the private route table name a variable"
  type        = string
  default     = "ECS-Private-Route-Table"
}

#Internet Routing
variable "internetgateway_name" {
  description = "making the internet gateway name a variable"
  type        = string
  default     = "ECS-GW"
}

variable "eip_name" {
  description = "making the eip name a variable"
  type        = string
  default     = "ECS-eip"
}

variable "eip_address" {
  description = "making the eip address a variable"
  type        = string
  default     = "200.150.10.10"
}

variable "nat_gateway_name" {
  description = "making the nat gateway name a variable"
  type        = string
  default     = "ECS-NAT"
}

#Security Groups
variable "external_alb_sec_name" {
  description = "making the external ALB security group name a variable"
  type        = string
  default     = "ECS-Ex-ALB"
}

variable "internal_alb_sec_name" {
  description = "making the internal ALB security group name a variable"
  type        = string
  default     = "ECS-In-ALB"
}

variable "http_port" {
  description = "making the http port a variable"
  type        = string
  default     = "80"
}

variable postgres_db_port {
    description = "making the progres db port a variable"
    default = "5432"
    type = string 
}

variable "rds_sec_name" {
  description = "making the RDS security group name a variable"
  type        = string
  default     = "ECS-RDS"
}

#RDS
variable "rds_subnet_name" {
  description = "making the RDS subnet name a variable"
  type        = string
  default     = "ECS-RDS-Subnet"
}

variable rds_engine {
    description = "making the rds engine a variable"
    default = "postgres"
    type = string  
}

variable rds_engineversion {
    description = "making the rds engine version a variable"
    default = "13.3"
    type = string  
}

variable rds_instanceclass {
    description = "making the rds instance class a variable"
    default = "db.t3.micro"
    type = string  
}

variable db_name {
    description = "making the database name a variable"
    default = "mypostgres"
    type = string 
}

variable rds_username {
    description = "making the rds username a variable"
    default = "ecsfinal"
    type = string 
}

variable rds_password {
    description = "making the rds password a variable"
    default = "theyear2023"
    type = string 
}

variable allocated_storage {
    description = "making the rds allocated storage a variable"
    default = "10"
    type = string 
}

variable storage_type {
    description = "making the rds storage type a variable"
    default = "gp2"
    type = string 
}

variable network_type {
    description = "making the rds network type a variable"
    default = "IPV4"
    type = string 
}

variable rds_name {
    description = "making the rds name a variable"
    default = "ecs_rds"
    type = string 
}

#ALB
variable alb_name {
    description = "making the ALB name a variable"
    default = "ecs-alb"
    type = string 
}

variable loadbalancer_type {
    description = "making the load balancer type a variable"
    default = "application"
    type = string 
}

variable target_group_name {
    description = "making the target group name a variable"
    default = "ecs-target"
    type = string 
}

variable target_type {
    description = "making the target group target type a variable"
    default = "ip"
    type = string 
}

variable healthcheck_path {
    description = "making the the target group health check path a variable"
    default = "/"
    type = string 
}

#IAM
variable task_role_name {
    description = "making the iam task role name a variable"
    default = "task_role"
    type = string 
}

variable ecs_task_policy_name {
    description = "making the iam task policy name a variable"
    default = "ecs_task_policy"
    type = string 
}

variable policy-attachment_name {
    description = "making the iam policy attachment name a variable"
    default = "policy-attachment"
    type = string 
}

variable task_execution_role_name {
    description = "making the iam task execution role name a variable"
    default = "task_execution_role"
    type = string 
}

#ECS
variable ecscluster_name {
    description = "making the ECS cluster name a variable"
    default = "ecs-nginx"
    type = string 
}