output "vpc_id" { 
    value = module.vpc.vpc_id 
}

output "public_subnets" { 
    value = module.vpc.public_subnets 
}

output "private_subnets" { 
    value = module.vpc.private_subnets 
}

output "alb_dns_name" { 
    value = module.alb.alb_dns_name 
}

output "ec2_instance_id" { 
    value = module.ec2.ec2_instance_id 
}

output "rds_endpoint" { 
    value = module.rds.rds_endpoint 
}

output "redis_primary_endpoint" { 
    value = module.redis.redis_primary_endpoint 
}