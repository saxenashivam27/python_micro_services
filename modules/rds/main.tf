resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_sg_id]
  }
  
  egress { 
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"] 
    }
}

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.private_subnets
  tags       = { 
    Name = "${var.project}-rds-subnet-group" 
    }
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project}-postgres"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.2"
  instance_class          = "db.t3.micro"
  db_name                 = "mydb"
  username                = "dbadmin"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7
  storage_encrypted       = true
  tags                    = { 
    Name = "${var.project}-postgres" 
    }
  depends_on = [
    module.vpc,
    aws_security_group.rds_sg
  ]
}
