# expensive.food

## Getting Started
This uses terraform and [terragrunt](TERRAGRUNT.md) to deploy resources.

### Tools and Versions tested
[Terraform](https://www.terraform.io/) 1.3.8
[Terragrunt](https://terragrunt.gruntwork.io/) 0.43.2
[Inspec](https://github.com/inspec/inspec) 5.21.29

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
  Terraform-->>Terragrunt: Complete
  loop Variablesetup
    Terragrunt-->>Terragrunt: ENV and TFvars
    Terragrunt-->>Terragrunt: retrieve module source
  end
  Terragrunt-->>Terraform: Init and Apply
  Terraform-->>F5XC Provider: Here's a resource declaration
  F5XC Provider-->>F5XC: F5XC API calls
  F5XC-->>F5XC Provider: Complete
  F5XC Provider-->>Terraform: Complete
  Terraform-->>Terragrunt: Complete

```


```mermaid
graph TD
  aws-appstack-site-1 --> aws-base-1;
  aws-appstack-site-1 --> mk8s-cluster-1;
  aws-base-1 --> udf-env-setup;
  gitops-lab --> aws-appstack-site-1;
  mk8s-cluster-1 --> udf-env-setup;
```

