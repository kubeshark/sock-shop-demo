module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

#   eks_addons = {
#     aws-ebs-csi-driver = {
#       most_recent = true
#     }
#     coredns = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#   }

  enable_aws_load_balancer_controller    = true
  enable_kube_prometheus_stack           = false
  enable_metrics_server                  = true
  enable_external_secrets                = false
  enable_ingress_nginx                   = false
  enable_argocd                          = true
  enable_cluster_proportional_autoscaler = false
  enable_external_dns                    = false
  enable_karpenter                       = false
  enable_cert_manager                    = false
  # cert_manager_route53_hosted_zone_arns  = ["arn:aws:route53:::hostedzone/Z0228234LL1EEPKD5KBY"]

  ingress_nginx = {
    values        = [templatefile("${path.module}/values/ingress-nginx.yaml", {})]
  }

  aws_load_balancer_controller = {
    set = [
      {
        name  = "vpcId"
        value = module.vpc.vpc_id
      },
      {
        name  = "podDisruptionBudget.maxUnavailable"
        value = 1
      },
      {
        name  = "enableServiceMutatorWebhook"
        value = "false"
      }
    ]
  }

  tags = {
    Environment = "dev"
  }
}

resource "helm_release" "kubeshark" {
  name = "kubeshark"
  repository = "https://helm.kubeshark.co"
  chart = "kubeshark"
  values = [templatefile("${path.module}/values/kubeshark.yaml", {})]
}

resource "kubectl_manifest" "sock-shop" {
  yaml_body = templatefile("${path.module}/values/sock-shop-demo.yaml", {})
  wait_for_rollout = true
}