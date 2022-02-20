// main.tf

module "vpc" {
  source = "../../../terraform/modules/vpc"
}

module "eks" {
  source          = "../../../terraform/modules/eks"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}


