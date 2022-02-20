// main.tf

module "vpc" {
  source = "../../../terraform/modules/vpc"
}

module "eks" {
  source          = "../../../terraform/modules/eks"
  vpc_id          = module.vpc.vpc_id
  private_subnets = data.terraform_remote_state.infra.private_subnets
  public_subnets  = data.terraform_remote_state.infra.public_subnets
}
