variable "region" {
  description = "aws region"
}

variable "app" {
  description = "Project Name"
}
variable "environment" {
  type        = string
  description = "The Name  of Environment"
} 
variable "cidr" {
  type        = string
  description = "The Name  of CIDR Block"
}
variable "public_cidr1" {
  type        = string
  description = "The Name  of 1st Public Subnet"
}
variable "public_cidr2" {
  type        = string
  description = "The Name  of 2nd Public Subnet"
}
variable "private_cidr1" {
  type        = string
  description = "The Name  of 1st Private Subnet"
}
variable "private_cidr2" {
  type        = string
  description = "The Name  of 2nd Private Subnet"
}
#ECS Variables
variable "repository_name" {
  type        = string
  description = "The Name  of ECR"
}
variable "cluster_name" {
  type        = string
  description = "The Name  of ECS Cluster"
}
variable "task_def_name" {
  type        = string
  description = "The Name  of Task Definition for ECS"
}
variable "container_name" {
  type        = string
  description = "The Name  of Container Running inside ECS Task Definition"
}
variable "containerPort" {
  type        = number
  description = "Container Port"
}
variable "hostPort" {
  type        = number
  description = "Host Port"
}

variable "service_name" {
  type        = string
  description = "The Name  of ECS Service"
}
# ALB Variables
variable "alb_name" {
  type        = string
  description = "The Name  of Application LoadBalancer"
}
variable "alb_target_group_name" {
  type        = string
  description = "The Name  of Application LoadBalancer's Target Group"
}