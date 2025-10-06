resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-ec2-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    security_groups = [var.alb_sg_id]
  }

  ingress { 
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"] 
    }

  egress { 
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"] 
    }
}

resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3 git
              pip3 install flask redis psycopg2-binary
              cd /home/ec2-user
              git clone ${var.app_repo}
              cd app && python3 app.py
              EOF
  depends_on = [
    module.iam
  ]
}

resource "aws_lb_target_group_attachment" "app_attach" {
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.app.id
  port             = var.app_port
  depends_on = [
    aws_instance.app,
    module.alb
  ]
}
