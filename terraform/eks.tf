module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  eks_managed_node_groups = {
    main = {
      instance_types = ["t3.small"]
      min_size       = 2
      max_size       = 3
      desired_size   = 2

      subnet_ids = module.vpc.private_subnets
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    Name = var.cluster_name
  }
}
