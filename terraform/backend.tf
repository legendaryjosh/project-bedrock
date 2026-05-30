terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-alt-soe-025-3710"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
