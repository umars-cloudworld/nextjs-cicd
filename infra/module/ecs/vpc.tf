# Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}
#VPC Creation
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "${var.app}-${var.environment}-vpc"
  }
}
#Internet Gateway Creation and Attachment to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}-${var.environment}-igw"
  }
}
#Public Route Table 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app}-${var.environment}-Public-Route-Table"
  }
}
#Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app}-${var.environment}-Private-App-Route-Table"
  }
}
#Routes with IGW 
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.public_rt]
}
#Public Subnet 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app}-${var.environment}-Public-Subnet-${data.aws_availability_zones.available.names[0]}"
  }
}
#Public Subnet 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app}-${var.environment}-Public-Subnet-${data.aws_availability_zones.available.names[1]}"
  }
}
#Private Subnet 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr1
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.app}-${var.environment}-Private-app-Subnet-${data.aws_availability_zones.available.names[0]}"
  }
}
#Private Subnet 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.app}-${var.environment}-Private-app-Subnet-${data.aws_availability_zones.available.names[1]}"
  }
}
#Public Subnet 1 Association 
resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}
#Public Subnet 2 Association 
resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}
#Private Subnet 1 Association rt
resource "aws_route_table_association" "private_rt_association_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}
#Private Subnet 2 Association rt 
resource "aws_route_table_association" "private_rt_association_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}