# The First periority for --var
# Second values.auto.tfvars
# Third terraform.tfvars

vpc-terraform-cidr_block = "10.0.0.0/16"
anyOne-cidr = "0.0.0.0/0"
ubuntu-instance = ["t2.micro", "Sprints-Key-pair"]

subnet-terraform = {
  "public-subnet-terraform" = ["10.0.0.0/24","us-east-1a"],
  "public-2-subnet-terraform" = ["10.0.2.0/24","us-east-1b"],
  "private-subnet-terraform" = ["10.0.1.0/24","us-east-1c"],
  "private-2-subnet-terraform" = ["10.0.3.0/24","us-east-1d"],
}

