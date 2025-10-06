variable "project" {}

variable "aws_region" { 
    default = "us-east-1" 
}

variable "vpc_cidr" { 
    default = "10.0.0.0/16" 
}

variable "azs" { 
    default = ["us-east-1a","us-east-1b"] 
}

variable "ami_id" {}

variable "instance_type" { 
    default = "t3.micro" 
}

variable "key_name" {}

variable "app_port" { default = 5000 }

variable "app_repo" {}

variable "db_password" {}