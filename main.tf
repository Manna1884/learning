#Defining Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

#Creating a VPC
resource "aws_vpc" "ecs_project" {
  cidr_block            = var.vpc_cidr
  instance_tenancy      = var.vpc_default
  enable_dns_support    = var.dns_support
  enable_dns_hostnames  = var.dns_hostnames
 
  tags = {
    Name = var.vpc_name
  }
}

#Creating Public Subnets
resource "aws_subnet" "subnet_public1" {
  vpc_id     = aws_vpc.ecs_project.id
  cidr_block = var.public1_cidr
  availability_zone = var.availability_zone1

  tags = {
    Name = var.publicsubnet1_name
  }
}

resource "aws_subnet" "subnet_public2" {
  vpc_id     = aws_vpc.ecs_project.id
  cidr_block = var.public2_cidr
  availability_zone = var.availability_zone2

  tags = {
    Name = var.publicsubnet2_name
  }
}

#Creating Private Subnets
resource "aws_subnet" "subnet_private1" {
  vpc_id     = aws_vpc.ecs_project.id
  cidr_block = var.private1_cidr
  availability_zone = var.availability_zone1

  tags = {
    Name = var.privatesubnet1_name
  }
}

resource "aws_subnet" "subnet_private2" {
  vpc_id     = aws_vpc.ecs_project.id
  cidr_block = var.private2_cidr
  availability_zone = var.availability_zone2

  tags = {
    Name = var.privatesubnet2_name
  }
}

#Creating Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ecs_project.id

  tags = {
    Name = var.publicroute_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.ecs_project.id

  tags = {
    Name = var.privateroute_name
  }
}

#Associating Route Tables To Subnets
resource "aws_route_table_association" "public-route-table-association1" {
  subnet_id      = aws_subnet.subnet_public1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-route-table-association2" {
  subnet_id      = aws_subnet.subnet_public2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private-route-table-association1" {
  subnet_id      = aws_subnet.subnet_private1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private-route-table-association2" {
  subnet_id      = aws_subnet.subnet_private2.id
  route_table_id = aws_route_table.private_route_table.id
}

#Creating Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ecs_project.id

  tags = {
    Name = var.internetgateway_name
  }
}

#Association of the Internet Gateway with the public route table/Route for Internet Gateway
resource "aws_route" "public-igw-route" {
  route_table_id            = aws_route_table.public_route_table.id
  gateway_id                = aws_internet_gateway.gw.id
  destination_cidr_block    = "0.0.0.0/0"
}

#Creating Elastic IP
resource "aws_eip" "eip" {
  vpc                       = true
  associate_with_private_ip = var.eip_address

 tags = {
    Name = var.eip_name
  }
}

#NAT Gateway for Internet through the Public Subnet
  resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_public1.id

 tags = {
    Name = var.nat_gateway_name
   }
 }

 # Route NAT GW with Private Route Table
resource "aws_route" "nat_gw_association_private_rt" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}


