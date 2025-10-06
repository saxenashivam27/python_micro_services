variable "project" {}

variable "vpc_id" {}

variable "private_subnets" { 
    type = list(string) 
}

variable "app_sg_ids" { 
    type = list(string) 
}