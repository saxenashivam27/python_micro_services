project = "python-microservice"

aws_region = "us-east-1"
azs       = ["us-east-1a", "us-east-1b"]

vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

ami_id        = "ami-0ff8a91507f77f867"
instance_type = "t3.micro"
key_name      = "my-key"
app_port      = 5000
app_repo      = "https://github.com/saxenashivam27/python_micro_services.git"

db_password = "SecureP@ssword123"
db_username = "dbadmin"
db_instance_class = "db.t3.micro"
db_allocated_storage = 20

alb_name       = "python-app-alb"
alb_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
alb_listener_port = 80

iam_role_name = "python-microservice-ec2-role"