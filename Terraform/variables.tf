variable "vpc-terraform-cidr_block" {
  description = "refer to vpc CIDR"
  type = string
  default = "10.0.0.0/16"
}
# ----------------------------


variable "subnet-terraform" {
  type = map
  default = {
  "public-subnet-terraform" = "10.0.0.0/24",
  "public-2-subnet-terraform" = "10.0.2.0/24",
  "private-subnet-terraform" = "10.0.1.0/24",
  "private-2-subnet-terraform" = "10.0.3.0/24",
}
}
# ----------------------------

variable "anyOne-cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "ubuntu-instance" {
  type = list
  default = ["t2.micro", "Sprints-Key-pair"]
}

