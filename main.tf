provider "aws" { region = "eu-north-1" }

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "xyz-eks"
  cluster_version = "1.29"
  subnets         = ["subnet-123", "subnet-456"]--------------
  vpc_id          = "vpc-123"--------------
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_token
}

resource "kubernetes_deployment" "app" {
  metadata { name = "xyz-app" }
  spec {
    replicas = 1
    selector { match_labels = { app = "xyz" } }
    template {
      metadata { labels = { app = "xyz" } }
      spec {
        container {
          name  = "xyz"
          image = "dockerhubusername/xyz:latest"-------------------
          port { container_port = 3000 }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata { name = "xyz-service" }
  spec {
    type = "LoadBalancer"
    selector = { app = "xyz" }
    port { port = 80 target_port = 3000 }
  }
}
