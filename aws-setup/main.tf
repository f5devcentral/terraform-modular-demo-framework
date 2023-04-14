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

locals {
    cloud_accounts = jsondecode(data.http.cloud_accounts.response_body).cloudAccounts
    aws_accounts   = [for account in local.cloud_accounts: account if account.provider == "AWS"]
    deployment     = jsondecode(data.http.deployment.response_body).deployment
    namespace      = "dcma"
}

resource "volterra_cloud_credentials" "example" {
  name      = format("aws-%s",local.deployment.id)
  namespace = local.namespace
  aws_secret_key {
    access_key = local.aws_accounts.0.apiKey
    secret_key {
      blindfold_secret_info_internal {
        location = format("string:///%s",base64encode(local.aws_accounts.0.apiSecret))
      }
    }
  }
}