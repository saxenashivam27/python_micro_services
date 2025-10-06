variable "project" {}

variable "vpc_id" {}

variable "private_subnets" { 
    type = list(string) 
}

variable "app_sg_id" {}

variable "db_password" { 
    type = string
    sensitive = true 
}