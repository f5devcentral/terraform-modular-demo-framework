data http cloud_accounts {
    url = "http://10.1.1.1/cloudAccounts"
    request_headers = {
        Accept = "application/json"
    }
}
data http deployment {
    url = "http://10.1.1.1/deployment"
    request_headers = {
        Accept = "application/json"
    }
}
variable volterra_cloud_cred_aws {
  default = "aws"
}
variable volterra_cloud_cred_azure {
  default = "azure"
}
output volterra_cloud_cred_aws {
  value = volterra_cloud_credentials.aws.name
}
output volterra_cloud_cred_azure {
  value = var.volterra_cloud_cred_azure
}
locals {
    cloud_accounts        = jsondecode(data.http.cloud_accounts.response_body).cloudAccounts
    aws_accounts          = [for account in local.cloud_accounts: account if account.provider == "AWS"]
    deployment            = jsondecode(data.http.deployment.response_body).deployment
    namespace             = "system"
    aws_cloud_credential_name = format("%s-%s",var.volterra_cloud_cred_aws,local.deployment.id)
}

resource "volterra_cloud_credentials" "aws" {
  name      = local.aws_cloud_credential_name
  namespace = local.namespace
  aws_secret_key {
    access_key = local.aws_accounts.0.apiKey
    secret_key {
      clear_secret_info {
        url = format("string:///%s",base64encode(local.aws_accounts.0.apiSecret))
      }
    }
  }
}

terraform {
  required_version = ">= 0.12.7"
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
     }
    }
}