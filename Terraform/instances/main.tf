data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["amazon"]  # Canonical owner ID for Ubuntu AMIs

  # I used this command in aws console to descripe specific image
  # aws ec2 describe-images --image-ids ami-053b0d53c279acc90 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]

    # for latest version you turned on most_recent then use * like in dates
    # values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    # or in whole ubuntu images
    # values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
    ## Note that the result my is not "Free tier eligible" for production purpose this is ok
  }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
#   filter {
#     name   = "description"
#     values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16"]
#   }

}

resource "aws_instance" "terraform-instance" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.ubuntu-instance[0]
  key_name      = var.ubuntu-instance[1]
  vpc_security_group_ids = [
    var.securityG_id
  ]
  subnet_id = var.id-subnet_terraform
  # Make it variable
  associate_public_ip_address = var.is_public_ip
  user_data = var.user_data_script

  provisioner "local-exec" {
    # when = destroy
    # on_failure = continue

    # This will create file on my local machine that contains ip of the created instance "EC2"
    # command = "echo ${var.command} ${self.Public-ip} >> ./all-ips.txt"
    # command = var.command
    command = <<-EOT
      echo ${var.instance_tag_name} >> ./all-ips.txt
      echo -------------------------------------------------- >> ./all-ips.txt
      echo Public-ip: ${self.public_ip} >> ./all-ips.txt
      echo Private-ip: ${self.private_ip} >> ./all-ips.txt
      echo -------------------------------------------------- >> ./all-ips.txt
      echo "" >> ./all-ips.txt
    EOT
  }

  tags = {
    Name = var.instance_tag_name
  }
}
