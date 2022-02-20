module "aws_module_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "gitops-vpc"
  cidr = "10.0.0.0/19"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.0.0/20"]
  public_subnets  = ["10.16.0.0/20"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

// ------------- Outputs

output "vpc_id" {
  value = module.aws_module_vpc.vpc_id
}

output "private_subnets" {
    value = module.private_subnets
}

output "public_subnets" {
    value = module.public_subnets
}
