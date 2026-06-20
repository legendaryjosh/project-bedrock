# Project Bedrock — AWS EKS Capstone

## Overview
Production-grade microservices deployment on AWS EKS for InnovateMart Inc.

## Infrastructure
- **VPC:** project-bedrock-vpc (us-east-1)
- **EKS Cluster:** project-bedrock-cluster (v1.31)
- **RDS MySQL:** catalog database
- **RDS PostgreSQL:** orders database
- **DynamoDB:** project-bedrock-cart (shopping cart)
- **S3:** bedrock-assets-alt-soe-025-3710
- **Lambda:** bedrock-asset-processor

## Application URL
http://k8s-retailap-retailst-17d19cf248-902051074.us-east-1.elb.amazonaws.com

## Developer Credentials (bedrock-dev-view)
- Access Key ID: AKIAUGZPRGMNWOYFDDPN
- Console Login: https://289473114907.signin.aws.amazon.com/console
- Username: bedrock-dev-view
- Password: (submitted separately)

## How to Trigger the Pipeline

### PR (triggers terraform plan)
```bash
git checkout -b feature/my-change
# make changes
git push origin feature/my-change
# open PR on GitHub → triggers terraform plan
```

### Merge to Main (triggers terraform apply)
```bash
git checkout main
git merge feature/my-change
git push origin main
# triggers terraform apply automatically
```

## Deploy Application
```bash
# Connect to cluster
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster

# Deploy app
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/retail-store-app.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/rbac.yaml
```

## Generate Grading File
```bash
cd terraform
terraform output -json > ../grading.json
```

## Tags
All resources tagged with: `Project: karatu-2025-capstone`
# Project Bedrock - AWS EKS Capstone
 
# CI/CD test
