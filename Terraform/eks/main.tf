# data "aws_iam_policy_document" "eks_cluster_policy" {
#   statement {
#     actions = [
#       "eks:DescribeCluster",
#       "eks:DescribeUpdate",
#       "eks:DescribeAddon",
#       "eks:ListClusters",
#       "eks:ListUpdates",
#       "eks:ListAddons",
#       "eks:CreateAddon",
#       "eks:DeleteAddon",
#       "eks:UpdateAddon",
#       "eks:TagResource",
#       "eks:UntagResource",
#       "eks:UpdateClusterVersion",
#       "eks:UpdateClusterConfig",
#       "eks:UpdateNodegroupConfig",
#       "eks:CreateFargateProfile",
#       "eks:DeleteFargateProfile",
#       "eks:UpdateFargateProfile",
#       "eks:CreateNodegroup",
#       "eks:DeleteNodegroup",
#       "eks:UpdateNodegroupVersion",
#       "eks:UpdateNodegroupConfig",
#       "eks:TagResource",
#       "eks:UntagResource",
#       "eks:AssociateEncryptionConfig",
#       "eks:DisassociateEncryptionConfig",
#       "eks:CreateClusterConfig",
#       "eks:DeleteClusterConfig",
#       "eks:DescribeClusterConfig",
#       "eks:ListClusterConfigs",
#       "eks:UpdateClusterConfig",
#       "eks:CreateAddonVersion",
#       "eks:DescribeAddonVersions",
#       "eks:ListAddonVersions",
#       "eks:DeleteAddonVersion",
#       "eks:CreateUpdate",
#       "eks:DeleteUpdate",
#       "eks:UpdateAddonVersion",
#       "eks:CreateNodegroup",
#       "eks:DeleteNodegroup",
#       "eks:UpdateNodegroupConfig",
#       "eks:UpdateNodegroupVersion",
#       "eks:CreateFargateProfile",
#       "eks:DeleteFargateProfile",
#       "eks:UpdateFargateProfile",
#       "eks:CreateClusterConfig",
#       "eks:DeleteClusterConfig",
#       "eks:DescribeClusterConfig",
#       "eks:ListClusterConfigs",
#       "eks:UpdateClusterConfig",
#       "eks:CreateAddonVersion",
#       "eks:DescribeAddonVersions",
#       "eks:ListAddonVersions",
#       "eks:DeleteAddonVersion",
#       "eks:CreateUpdate",
#       "eks:DeleteUpdate",
#       "eks:UpdateAddonVersion"
#     ]

#     resources = [
#       "arn:aws:eks:us-east-1:123456789012:cluster/my-eks-cluster",
#       "arn:aws:eks:us-east-1:123456789012:nodegroup/my-eks-cluster/*"
#     ]
#   }
# }

resource "aws_iam_role" "eks_cluster_role" {
  name = "my-eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# resource "aws_iam_policy" "eks_cluster_policy" {
#   name   = "my-eks-cluster-policy"
#   policy = data.aws_iam_policy_document.eks_cluster_policy.json
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = aws_iam_policy.eks_cluster_policy.arn
# }

# --------------------------------------------------------

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.0.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"

  vpc_id = "vpc-12345678"  # Replace with your VPC ID

  subnet_ids = [
    "subnet-12345678",  # Replace with your subnet IDs
    "subnet-23456789",
    "subnet-34567890"
  ]

  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 3
    }
  ]
}
