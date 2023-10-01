# VPC Module

module "sprints-vpc-1" {
  source = "./vpc"
  vpc-terraform-cidr_block = var.vpc-terraform-cidr_block
  subnet-terraform = var.subnet-terraform
  anyOne-cidr = var.anyOne-cidr
}

# -------------------------------------

# Instances and Provisioned-instances Module

# module "terraform-instance-Public" {
#   source = "./instances"
#   ubuntu-instance = var.ubuntu-instance
#   is_public_ip = true
#   securityG_id = module.sprints-vpc-1.id_terraform-securityG
#   id-subnet_terraform = module.sprints-vpc-1.id_public-1-subnet_terraform
#   user_data_script = var.user_data_script
#   # command = "echo ${module.terraform-instance-Public.Public-ip} >> ./private_ip.txt"
#   # command = "echo Public-ip: ${module.terraform-instance-Public.Public-ip} >> ./all-ips.txt"
#   instance_tag_name = "terraform-instance-Public"
# }

module "terraform-instance-Provisioned" {
  source = "./provisioned-instances"
  ubuntu-instance = var.ubuntu-instance
  securityG_id = module.sprints-vpc-1.id_terraform-securityG
  id-subnet_terraform = module.sprints-vpc-1.id_public-2-subnet_terraform
  # user_data_script = var.user_data_script
  instance_tag_name = "terraform-instance-Provisioned"
}

# module "terraform-instance-Private" {
#   source = "./instances"
#   ubuntu-instance = var.ubuntu-instance
#   is_public_ip = false
#   securityG_id = module.sprints-vpc-1.id_terraform-securityG-private
#   id-subnet_terraform = module.sprints-vpc-1.id_private-1-subnet_terraform
#   user_data_script = var.user_data_script_private
#   # command = "echo Private-ip: ${module.terraform-instance-Private.Private-ip} >> ./all-ips.txt"
#   instance_tag_name = "terraform-instance-Private"
# }

# -------------------------------------

# ECR Module

module "terraform-ecr" {
  source = "./ecr"
  ecr_tag_name = "sprints-ecr"
}

# -------------------------------------

# EKS Module

module "terraform-eks" {
  source = "./eks"
  eks_subnets = [module.sprints-vpc-1.id_public-1-subnet_terraform, module.sprints-vpc-1.id_public-2-subnet_terraform]
  # instance-subnet_id = module.sprints-vpc-1.id_public-1-subnet_terraform
  vpc_security_group_ids = module.sprints-vpc-1.id_terraform-securityG
  key_pair_name = var.ubuntu-instance[1]
  eks_tag_name = "sprints-eks"
  anyOne-cidr= var.anyOne-cidr
  eks_SG_vpc= module.sprints-vpc-1.vpc_id
}
