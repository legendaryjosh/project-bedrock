# Developer IAM User
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"

  tags = {
    Name = "bedrock-dev-view"
  }
}

# Console Login Profile
resource "aws_iam_user_login_profile" "dev_view" {
  user                    = aws_iam_user.dev_view.name
  password_reset_required = false
}

# Access Keys for CLI/API access
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# Attach ReadOnlyAccess managed policy
resource "aws_iam_user_policy_attachment" "dev_view_readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Scoped S3 PutObject policy for assets bucket
resource "aws_iam_user_policy" "dev_view_s3" {
  name = "bedrock-dev-s3-putobject"
  user = aws_iam_user.dev_view.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${var.assets_bucket_name}/*"
      }
    ]
  })
}

# EKS Access Entry for RBAC
resource "aws_eks_access_entry" "dev_view" {
  cluster_name      = module.eks.cluster_name
  principal_arn     = aws_iam_user.dev_view.arn
  kubernetes_groups = ["bedrock-dev-group"]

  tags = {
    Name = "bedrock-dev-view-access"
  }
}
