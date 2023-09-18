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

## Input Variables

- `env_name` (string, optional): Sets the environment name (default: "development").
- `region` (string, optional): Defines the AWS region where the EKS cluster will be deployed (default: "us-east-2").

## Output

This Terraform module does not produce any specific output, but it creates an EKS cluster in your AWS account.

## Contributions

Contributions are welcome! Please open an issue or submit a pull request with improvements or fixes.

## License

This Terraform module is distributed under the [Apache License](LICENSE).
