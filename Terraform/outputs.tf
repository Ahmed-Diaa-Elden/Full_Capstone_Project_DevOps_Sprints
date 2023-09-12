output "Public-ip-terraform-instance" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = module.terraform-instance-Public.Public-ip
}

output "Private-ip-terraform-instance" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.terraform-instance-Private.Private-ip
}

output "Public-ip-terraform-instance-2" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = module.terraform-instance-Provisioned.Public-ip
}

output "Private-ip-terraform-instance-2" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.terraform-instance-Private-2.Private-ip
}

output "Public-dns-ld" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.Public-Load_balancer.dns-terraform-instance
}

output "AMI_From_Datasource" {
  # value = aws_instance.terraform-instance-Private.private_ip
  value = module.terraform-instance-Public.latest_ubuntu_ami_id
}

