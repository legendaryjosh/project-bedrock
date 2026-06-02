variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "project-bedrock-cluster"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "project-bedrock-vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "Private Subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public Subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "assets_bucket_name" {
  description = "S3 Assets Bucket Name"
  type        = string
  default     = "bedrock-assets-alt-soe-025-3710"
}

variable "lambda_function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = "bedrock-asset-processor"
}

variable "app_namespace" {
  description = "Kubernetes Namespace"
  type        = string
  default     = "retail-app"
}

variable "db_username" {
  description = "Database Master Username"
  type        = string
  default     = "bedrockadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Database Master Password"
  type        = string
  sensitive   = true
}
