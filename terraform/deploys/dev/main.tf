// main.tf

module "eks" {
  source          = "../../../terraform/modules/eks"
  vpc_id          = data.terraform_remote_state.infra.outputs.vpc_id
  private_subnets = data.terraform_remote_state.infra.outputs.private_subnets
  public_subnets  = data.terraform_remote_state.infra.outputs.public_subnets
}
