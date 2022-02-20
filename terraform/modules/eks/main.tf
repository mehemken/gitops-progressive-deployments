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

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "t3.medium"
    update_launch_template_default_version = true
    iam_role_additional_policies           = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  }

  self_managed_node_groups = {
    one = {
      name = "default-ng"

      public_ip    = false
      max_size     = 3
      desired_size = 2

      //bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

      post_bootstrap_user_data = <<-EOT
      cd /tmp
      sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
      sudo systemctl enable amazon-ssm-agent
      sudo systemctl start amazon-ssm-agent
      EOT
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
