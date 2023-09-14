variable "eks_subnets" {
  type = list
  # default = [aws_subnet.public-1.id, aws_subnet.public-2.id]
}

variable "eks_tag_name" {
  type = string
  default = "sprints-ecr"
  # As hint
  # default = module.module-name.id_terraform-securityG
}

variable "instance-subnet_id" {
  type = string
  # default = "sprints-ecr"
}

variable "vpc_security_group_ids" {
  type = string
  # default = "sprints-ecr"
}

variable "key_pair_name" {
  type = string
  default = "Sprints-Key-pair"
}

