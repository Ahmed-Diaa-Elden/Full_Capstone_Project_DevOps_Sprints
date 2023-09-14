# variable "ubuntu-instance" {
#   type = list
#   default = ["t2.micro", "Sprints-Key-pair"]
# }

variable "ecr_tag_name" {
  type = string
  default = "sprints-ecr"
  # As hint
  # default = module.module-name.id_terraform-securityG
}
