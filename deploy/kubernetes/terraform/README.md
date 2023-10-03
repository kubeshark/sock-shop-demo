# Terraform Module IAC - Amazon EKS Cluster Creation

## Overview

This Terraform module enables easy creation of an Amazon Elastic Kubernetes Service (EKS) cluster in AWS. The EKS cluster is provisioned with custom configurations and can be seamlessly integrated with other infrastructure modules and resources.

## Requirements

- Terraform (version 0.12 or higher)
- Configured AWS credentials (access keys and secrets)

## Usage

1. Execute the following Terraform commands in your project directory:

   ```shell
   terraform init
   terraform plan
   terraform apply
   ```

   This will initialize Terraform, show the planned changes, and, if everything is correct, create the EKS cluster in your AWS account.

2. To destroy the EKS cluster when it's no longer needed, run:

   ```shell
   terraform destroy
   ```

### State storage

This module uses S3 to store the Terraform state. You can check the details of that bucket at `backend` on file `provider.tf`.

## Input Variables

- `env_name` (string, optional): Sets the environment name (default: "dko-6").
- `region` (string, optional): Defines the AWS region where the EKS cluster will be deployed (default: "us-east-1").
- `enable_kubeshark`(string, optional): Enables Kubeshark installation (default: false)
- `enable_sock_shop`(string, optional): Enables Sock Shop installation (default: false)
- `enable_kube_prometheus_stack`(string, optional): Enables Prometheus Stack installation (default: true)
- `enable_aws_cloudwatch_metrics`(string, optional): Enables CloudWhatch installation (default: true)
- `enable_ingress_nginx`(string, optional): Enables Nginx installation (default: false)
- `role_name`(string, optional): Default arn role name to be include into admin team

## Output

- `region`: The region where the cluster was created
- `cluster_name`: The name of the cluster created
- `configure_kubectl`: An aws-cli command to help you setup your kubeconfig file

## Contributions

Contributions are welcome! Please open an issue or submit a pull request with improvements or fixes.

## License

This Terraform module is distributed under the [Apache License](LICENSE).
