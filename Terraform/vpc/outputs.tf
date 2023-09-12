# output "id_output" {
#   value = aws_vpc.test.id
# }

output "vpc_id" {
  value = aws_vpc.vpc-terraform.id
}

output "id_terraform-securityG" {
  value = aws_security_group.terraform-securityG.id
}

output "id_terraform-securityG-private" {
  value = aws_security_group.terraform-securityG-privateInstance.id
}

output "id_public-1-subnet_terraform" {
  value = aws_subnet.subnet-terraform["public-subnet-terraform"].id
}

output "id_private-1-subnet_terraform" {
  value = aws_subnet.subnet-terraform["private-subnet-terraform"].id
}

output "id_public-2-subnet_terraform" {
  value = aws_subnet.subnet-terraform["public-2-subnet-terraform"].id
}

output "id_private-2-subnet_terraform" {
  value = aws_subnet.subnet-terraform["private-2-subnet-terraform"].id
}

