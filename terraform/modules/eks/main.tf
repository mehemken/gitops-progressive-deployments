module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = "gitops-eks"
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  //// This looks cool, but i'mma figure it out later
  //  cluster_encryption_config = [{
  //    provider_key_arn = "ac01234b-00d9-40f6-ac95-e42345f78b00"
  //    resources        = ["secrets"]
  //  }]

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["t3.medium"]
    //vpc_security_group_ids = [aws_security_group.additional.id]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      labels = {
        Environment = "dev"
        GithubRepo  = "gitops-progressive-deployments"
      }
      tags = {
        ExtraTag = "example"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
