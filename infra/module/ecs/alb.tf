resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = ["${aws_subnet.public_1.id}", "${aws_subnet.public_2.id}"]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb-tg" {
  name     = var.alb_target_group_name
  port     = var.containerPort
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  deregistration_delay = 20
  target_type          = "ip"

  health_check {
    path                = "/"
    port                = var.containerPort
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200" # has to be HTTP 200 or fails
  }
}


resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    type             = "forward"
  }
}
