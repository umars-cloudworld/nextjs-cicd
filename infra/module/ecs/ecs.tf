# Description: AWS ECR Repository Resource
# Usage: This resource is used to create an ECR repository in AWS.
resource "aws_ecr_repository" "repo" {
  name = var.repository_name

  image_tag_mutability = "MUTABLE"

  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}


resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = {
    Name        = "${var.app}-${var.environment}-cluster"
    Environment = var.environment
  }
}
resource "aws_ecs_cluster_capacity_providers" "capacity_provider" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
resource "aws_ecs_task_definition" "task-definition" {
  family                   = var.task_def_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "${aws_ecr_repository.repo.repository_url}"
    memory    = 256
    cpu       = 256
    essential = true
    environment = [
      {
        "name" : "NODE_ENV",
        "value" : "production"
      }
    ],
    portMappings = [
      {
        containerPort = var.containerPort,
        hostPort      = var.hostPort,
        protocol      = "tcp"
      }
    ]
  }])
}
resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task-definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = ["${aws_subnet.public_1.id}", "${aws_subnet.public_2.id}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    container_name   = var.container_name
    container_port   = var.containerPort
  }
}