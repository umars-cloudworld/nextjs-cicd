#VPC Outputs
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_1.id
}
output "public_subnet_2" {
  value = aws_subnet.public_2.id
}
output "private_subnet_1" {
  value = aws_subnet.private_1.id
}
output "private_subnet_2" {
  value = aws_subnet.private_2.id
}

#Security Group Outputs
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

#Load Balancer Output
output "alb_dns" {
  value = aws_lb.alb.dns_name
}
