variable "env_name" {
  default = "development"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "enable_kubeshark" {
  description = "Enables Kubeshark installation"
  type = bool
  default = false
}

variable "enable_sock_shop" {
  description = "Enables Sock Shop installation"
  type = bool
  default = false
}

variable "enable_kube_prometheus_stack" {
  description = "Enables Prometheus Stack installation"
  type = bool
  default = true
}

variable "enable_aws_cloudwatch_metrics" {
  description = "Enables Cloudwatch Metrics installation"
  type = bool
  default = true
}

variable "enable_ingress_nginx" {
  description = "Enables Ingress Nginx installation"
  type = bool
  default = false
}

