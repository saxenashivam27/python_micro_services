resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-alb-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { 
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
    }
  tags = { 
    Name = "${var.project}-alb-sg" 
    }
}

resource "aws_lb" "app_alb" {
  name               = "${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets
  tags               = { 
    Name = "${var.project}-alb" 
    }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "${var.project}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check { 
    path = "/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 3
    interval = 30
    timeout = 5 
    }
  tags = { 
    Name = "${var.project}-tg" 
    }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action { 
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn 
    }
}
