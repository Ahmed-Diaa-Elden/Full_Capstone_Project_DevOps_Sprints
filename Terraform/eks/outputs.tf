output "ecr-url" {
  description = "The ECR URL"
  value = aws_ecr_repository.sprints-ecr.repository_url
}
