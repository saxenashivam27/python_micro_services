variable "project" {}

variable "vpc_id" {}

variable "public_subnets" { 
    type = list(string) 
}

variable "app_port" {
    default = 5000 
}