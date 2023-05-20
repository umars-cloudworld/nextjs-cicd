resource "aws_security_group" "alb_sg" {
  name        = "LoadBalancer-${var.app}-${var.environment}-sg"
  description = "Security Group for LoadBalancer ${var.environment} env"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "HTTPS Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LoadBalancer-${var.app}-${var.environment}-sg"
  }
}
resource "aws_security_group" "ecs_sg" {
  name        = "ECS-${var.app}-${var.environment}-sg"
  description = "Security Group for ECS ${var.environment} env"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ECS-${var.app}-${var.environment}-sg"
  }
}