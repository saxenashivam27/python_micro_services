The workflow of the app is that the EC2 accepts traffic from anywhere and process it and enter the record into Postgres DB.

This structire is created with the assumption that python app is installed on EC2 instances which is processing data and creating record to be pushed to PostgresDB.

I have created modules for each resource to simplify usage by taking references from Internet.

To run it, please do the following
1.) Enter values under Values.tfvars
2.) Run commmand "terraform init"
3.) Run commmand "terraform validate"
4.) Run commmand "terraform plan -var-file="Values.tfvars" -out=tfplan"
5.) Run commmand "terraform apply -var-file="Values.tfvars  -auto-approve"

To destroy the infrastructure
1.) Run command "terraform destroy -var-file="Values.tfvars  -auto-approve"

For AWS Setup run below commands with actual values

1.) export AWS_ACCESS_KEY_ID="your_key"
2.) export AWS_SECRET_ACCESS_KEY="your_secret"
3.) export AWS_REGION="your_region"