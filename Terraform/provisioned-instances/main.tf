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

resource "aws_instance" "terraform-instance-Provisioned" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.ubuntu-instance[0]
  key_name      = var.ubuntu-instance[1]
  vpc_security_group_ids = [
    var.securityG_id
  ]
  subnet_id = var.id-subnet_terraform
  associate_public_ip_address = true
  # user_data = var.user_data_script

  tags = {
    Name = var.instance_tag_name
  }
}

  # I made null_resource specificly to make provisioner wait 60 seconds before executing but I think we didn't need null_resource as we wrote in command "sleep 60"
resource "null_resource" "Terraform_provisioner" {
  triggers = {
    instance_id = aws_instance.terraform-instance-Provisioned.id
  }

  connection {
    type     = "ssh"
    host     = aws_instance.terraform-instance-Provisioned.public_ip
    user     = "ubuntu"
    private_key = file("../../Sprints-Key-pair.pem")  # Replace with the path to your private key
  }

  # provisioner "file" {
  #   source      = "bash.sh"
  #   destination = "/home/ubuntu/bash.sh"
  # }

  # Wait for the instance to be fully launched before executing provisioner after 60 seconds
  provisioner "local-exec" {
    # when = destroy
    # on_failure = continue

    # This will create file on my local machine that contains ip of the created instance "EC2"
    command = <<-EOT
      sleep 60
      chmod u+x ../inventory.sh
      ./inventory.sh ${aws_instance.terraform-instance-Provisioned.public_ip}
    EOT
  
  }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod 700 /home/ubuntu/bash.sh",
#       # "sudo /home/ubuntu/bash.sh ${self.public_ip} ${aws_instance.apache_instance_2.private_ip}",
#       "sudo /home/ubuntu/bash.sh ${var.ld_public_dns} ${var.ld_private_dns}",
#       "sudo nginx -s reload",
#     ]
# }

}