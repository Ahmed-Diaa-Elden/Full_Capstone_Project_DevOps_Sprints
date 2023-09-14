resource "aws_ecr_repository" "sprints-ecr" {
  name                 = "sprints-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "dev",
    name = var.ecr_tag_name,
  }
}