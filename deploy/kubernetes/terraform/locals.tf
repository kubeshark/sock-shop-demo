locals {
  name            = "${var.env_name}-eks"
  cluster_version = "1.27"
  region          = var.region

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Release    = local.name
    Kind       = "demo"
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}