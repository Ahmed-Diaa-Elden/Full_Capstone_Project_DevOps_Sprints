# output "id_output" {
#   value = aws_vpc.test.id
# }

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
# The result "ami-053b0d53c279acc90"
}

output "Public-ip" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = aws_instance.terraform-instance.public_ip
}

output "Private-ip" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = aws_instance.terraform-instance.private_ip
}

output "instance-id" {
  # value = aws_instance.terraform-instance-Public.public_ip
  value = aws_instance.terraform-instance.id
}

