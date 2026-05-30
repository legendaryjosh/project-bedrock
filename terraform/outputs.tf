output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS Region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "assets_bucket_name" {
  description = "Assets S3 Bucket Name"
  value       = aws_s3_bucket.assets.bucket
}

output "mysql_endpoint" {
  description = "MySQL RDS Endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "postgresql_endpoint" {
  description = "PostgreSQL RDS Endpoint"
  value       = aws_db_instance.postgresql.endpoint
}

output "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  value       = aws_dynamodb_table.cart.name
}

output "dev_user_access_key" {
  description = "Developer IAM User Access Key ID"
  value       = aws_iam_access_key.dev_view.id
}

output "dev_user_secret_key" {
  description = "Developer IAM User Secret Access Key"
  value       = aws_iam_access_key.dev_view.secret
  sensitive   = true
}

output "dev_user_password" {
  description = "Developer IAM User Console Password"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}
