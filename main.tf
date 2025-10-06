terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "shivam_terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source   = "./modules/vpc"
  project  = var.project
  cidr     = var.vpc_cidr
  azs      = var.azs
}

module "iam" {
  source  = "./modules/iam"
  project = var.project
}

module "alb" {
  source         = "./modules/alb"
  project        = var.project
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "ec2" {
  vpc_id                  = module.vpc.vpc_id
  alb_sg_id               = module.alb.alb_sg_id
  source                  = "./modules/ec2"
  project                 = var.project
  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  app_port                = var.app_port
  alb_target_group_arn    = module.alb.alb_tg_arn
  subnet_id               = element(module.vpc.private_subnets, 0)
  iam_instance_profile    = module.iam.iam_instance_profile
  app_repo                = var.app_repo
}

module "rds" {
  source          = "./modules/rds"
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  app_sg_id       = module.ec2.ec2_sg_id
  db_password     = var.db_password
}

module "redis" {
  source          = "./modules/redis"
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  app_sg_ids      = [module.ec2.ec2_sg_id]
}