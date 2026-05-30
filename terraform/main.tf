# Data source to get EKS cluster auth token
data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.main.token
}

# Helm Provider
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

# Kubernetes Namespace
resource "kubernetes_namespace" "retail_app" {
  metadata {
    name = var.app_namespace
    labels = {
      name = var.app_namespace
    }
  }

  depends_on = [module.eks]
}

# Kubernetes RBAC - ClusterRoleBinding for dev user
resource "kubernetes_cluster_role_binding" "dev_view" {
  metadata {
    name = "bedrock-dev-view-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = "bedrock-dev-group"
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [module.eks]
}
