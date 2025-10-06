resource "aws_security_group" "redis_sg" {
  name        = "${var.project}-redis-sg"
  vpc_id      = var.vpc_id
  description = "Allow access to Redis from EC2"
  
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = var.app_sg_ids
  }
  
  egress { 
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"] 
    }
}

resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "${var.project}-redis-subnet-group"
  subnet_ids = var.private_subnets
  tags       = { 
    Name = "${var.project}-redis-subnet-group" 
    }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.project}-redis"
  description                   = "Redis cluster for caching"
  engine                        = "redis"
  engine_version                = "6.x"
  node_type                     = "cache.t3.micro"
  automatic_failover_enabled    = true
  multi_az_enabled              = true
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet.name
  security_group_ids            = [aws_security_group.redis_sg.id]
  port                          = 6379
  apply_immediately             = true
  depends_on = [
    aws_instance.app,
    module.alb
  ]
}
