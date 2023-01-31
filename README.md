# expensive.food

## Getting Started
This uses terraform and [terragrunt](TERRAGRUNT.md) to deploy resources.

## Preconditions

aws, az, and gcloud CLI installed

credentials with s
- AWS account
- Azure account
- GCP account

Distributed Cloud Cloud Credential for each of the platforms in the same accounts

```mermaid
sequenceDiagram
  participant Terragrunt
  participant Terraform
  participant AWS Provider
  participant AWS
  participant F5XC Provider
  participant F5XC
  loop Variablesetup
    Terragrunt-->>Terragrunt: ENV and TFvars
    Terragrunt-->>Terragrunt: retrieve module source
  end
  Terragrunt-->>Terraform: Init and Apply
  Terraform-->>AWS Provider: Here's a resource declaration
  AWS Provider-->>AWS: AWS API calls
  AWS-->>AWS Provider: Complete
  AWS Provider-->>Terraform: Complete


```


```mermaid
graph TD
  aws-vpc-site-1-->aws-base-1;
  aws-vpc-site-2-->aws-base-2;
  azure-site-1-->azure-base-1;
  azure-site-2-->azure-base-2;
  waitfor-aws-vpc-->aws-base-1;
  waitfor-aws-vpc-->aws-vpc-site-1;
  waitfor-aws-vpc-->aws-base-2;
  waitfor-aws-vpc-->aws-vpc-site-2;
  waitfornext-->azure-base-1;
  waitfornext-->azure-site-1;
  waitfornext-->azure-base-2;
  waitfornext-->azure-site-2;

```

