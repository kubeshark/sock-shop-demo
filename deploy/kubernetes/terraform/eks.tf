data "aws_availability_zones" "available" {}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    kube-proxy = {}
    vpc-cni    = {}
    coredns = {
      configuration_values = jsonencode({
        computeType = "Fargate"
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  eks_managed_node_groups = {
    managed = {
      iam_role_name              = "${local.name}-managed" # Backwards compat
      iam_role_use_name_prefix   = false                   # Backwards compat
      use_custom_launch_template = false                   # Backwards compat

      instance_types = ["m5.large"]

      min_size     = 1
      max_size     = 5
      desired_size = 3

      labels = {
        Which = "managed"
      }
    }
  }

  fargate_profiles = {
    fargate = {
      iam_role_name            = "${local.name}-fargate" # Backwards compat
      iam_role_use_name_prefix = false                   # Backwards compat

      selectors = [{
        namespace = "default"
        labels = {
          Which = "fargate"
        }
      }]
    }
  }

  self_managed_node_groups = {
    self_managed = {
      name            = "${local.name}-self_managed" # Backwards compat
      use_name_prefix = false                        # Backwards compat

      iam_role_name            = "${local.name}-self_managed" # Backwards compat
      iam_role_use_name_prefix = false                        # Backwards compat

      launch_template_name            = "self_managed-${local.name}" # Backwards compat
      launch_template_use_name_prefix = false                        # Backwards compat

      instance_type = "m5.large"

      min_size     = 1
      max_size     = 3
      desired_size = 2

      labels = {
        Which = "self-managed"
      }
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

resource "aws_iam_policy" "additional" {
  name = "${local.name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}