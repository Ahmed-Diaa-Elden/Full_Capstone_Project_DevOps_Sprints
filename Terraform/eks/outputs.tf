# output "ecr-url" {
#   description = "The ECR URL"
#   value = aws_ecr_repository.sprints-ecr.repository_url
# }

output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}
