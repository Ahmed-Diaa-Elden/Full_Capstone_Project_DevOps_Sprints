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
