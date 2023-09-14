variable "ubuntu-instance" {
  type = list
  default = ["t2.micro", "Sprints-Key-pair"]
}

variable "securityG_id" {
  type = string
  # As hint
  # default = module.module-name.id_terraform-securityG
}

variable "id-subnet_terraform" {
  type = string
  # default = module.module-name.id_public-1-subnet_terraform
}

variable "user_data_script" {
  type        = string
  # for installing nginx
  description = "The user data script to be executed on the EC2 instance"
  default = <<-EOT
    #!/bin/bash
    echo "Hello, this is the user data script."
    # Add your custom commands here
  EOT
}

# variable "ld_private_dns" {
#   type = string
#   # Hint
#   # aws_instance.apache_instance_2.private_ip
# }

# variable "ld_public_dns" {
#   type = string
#   # default = "echo ${self.private_ip} >> ./private_ip.txt"
# }

variable "instance_tag_name" {
  type = string
  default = "terraform-instance"
}
