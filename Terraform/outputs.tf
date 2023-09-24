output "Public-ip-terraform-instance-2" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = module.terraform-instance-Provisioned.Public-ip
}

output "AMI_From_Datasource" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.terraform-instance-Provisioned.latest_ubuntu_ami_id
}

output "AWS_load_balancer_controller_role_arn" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.terraform-eks.aws_load_balancer_controller_role_arn
}

output "ECR_URL" {
  value = module.terraform-ecr.ecr-url
}

