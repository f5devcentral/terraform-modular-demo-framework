# INPUTS AND OUTPUTS
variable volterra_cloud_cred_aws_prefix {
  default = "aws"
}
variable volterra_cloud_cred_azure_prefix {
  default = "azure"
}
variable ssh_public_key {
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}
output volterra_cloud_cred_aws {
  value = volterra_cloud_credentials.aws.name
}
output volterra_cloud_cred_azure {
  value = var.volterra_cloud_cred_azure_prefix
}
# LOCAL VARIABLES
locals {
    cloud_accounts             = jsondecode(data.http.cloud_accounts.response_body).cloudAccounts
    aws_accounts               = [for account in local.cloud_accounts: account if account.provider == "AWS"]
    deployment                 = jsondecode(data.http.deployment.response_body).deployment
    cloud_credential_namespace = "system"
    aws_cloud_credential_name  = format("%s-%s",var.volterra_cloud_cred_aws_prefix,local.deployment.id)
    azure_cloud_credential_name = var.volterra_cloud_cred_azure_prefix
    env_config = {
      user_namespace = replace(split("@",local.deployment.deployer)[0],".","-")
    }
    team_name = local.env_config.user_namespace
}
# QUERY UDF METADATA
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
# CREATE EPHEMERAL DISTRIBUTED CLOUD CLOUD CREDENTIAL
resource "volterra_cloud_credentials" "aws" {
  name      = local.aws_cloud_credential_name
  namespace = local.cloud_credential_namespace
  aws_secret_key {
    access_key = local.aws_accounts.0.apiKey
    secret_key {
      clear_secret_info {
        url = format("string:///%s",base64encode(local.aws_accounts.0.apiSecret))
      }
    }
  }
}
# ENV CONFIGURATION VARS
resource local_file envconfig {
  filename = "/home/ubuntu/terraform-modular-demo-framework/envconfig.demo.yaml"
  content = templatefile("/home/ubuntu/terraform-modular-demo-framework/udf-env-setup/ef.inputs.demo.template.yaml",{
    prefix = local.team_name,
    resourceowner = local.env_config.user_namespace
    awscloudcred = local.aws_cloud_credential_name
    azurecloudcred = local.azure_cloud_credential_name
    useremail = local.deployment.deployer
    awsec2keyname = local.team_name
    sshpublickey = var.ssh_public_key
    domainname = format("%s.labs.f5demos.com",local.team_name)
    azure_spn_clientid = "abc"
    azure_spn_password = "def"
  })

  provisioner "local-exec" {
    command = "sops -e /home/ubuntu/terraform-modular-demo-framework/envconfig.demo.yaml > /home/ubuntu/terraform-modular-demo-framework/ef.input.demo.yaml"
  }
}
# CREATE AWS EC2 KEYPAIRS
# TBD
provider aws {
  alias = "us-west-1"
  region = "us-west-1"
}
resource "aws_key_pair" "us-west-1" {
  provider = aws.us-west-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "us-west-2"
  region = "us-west-2"
}
resource "aws_key_pair" "us-west-2" {
  provider = aws.us-west-2
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "us-east-1"
  region = "us-east-1"
}
resource "aws_key_pair" "us-east-1" {
  provider = aws.us-east-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "us-east-2"
  region = "us-east-2"
}
resource "aws_key_pair" "us-east-2" {
  provider = aws.us-east-2
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ap-northeast-1"
  region = "ap-northeast-1"
}
resource "aws_key_pair" "ap-northeast-1" {
  provider = aws.ap-northeast-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ap-northeast-2"
  region = "ap-northeast-2"
}
resource "aws_key_pair" "ap-northeast-2" {
  provider = aws.ap-northeast-2
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ap-south-1"
  region = "ap-south-1"
}
resource "aws_key_pair" "ap-south-1" {
  provider = aws.ap-south-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ap-southeast-1"
  region = "ap-southeast-1"
}
resource "aws_key_pair" "ap-southeast-1" {
  provider = aws.ap-southeast-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ap-southeast-2"
  region = "ap-southeast-2"
}
resource "aws_key_pair" "ap-southeast-2" {
  provider = aws.ap-southeast-2
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "ca-central-1"
  region = "ca-central-1"
}
resource "aws_key_pair" "ca-central-1" {
  provider = aws.ca-central-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
# ca-central-2 fails
# provider aws {
#   alias = "ca-central-2"
#   region = "ca-central-2"
# }
# resource "aws_key_pair" "ca-central-2" {
#   provider = aws.ca-central-2
#   key_name   = local.team_name
#   public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
# }
provider aws {
  alias = "eu-west-1"
  region = "eu-west-1"
}
resource "aws_key_pair" "eu-west-1" {
  provider = aws.eu-west-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "eu-west-2"
  region = "eu-west-2"
}
resource "aws_key_pair" "eu-west-2" {
  provider = aws.eu-west-2
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "eu-west-3"
  region = "eu-west-3"
}
resource "aws_key_pair" "eu-west-3" {
  provider = aws.eu-west-3
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
provider aws {
  alias = "sa-east-1"
  region = "sa-east-1"
}
resource "aws_key_pair" "sa-east-1" {
  provider = aws.sa-east-1
  key_name   = local.team_name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}

# PROVIDER DECLARATION
terraform {
  required_version = ">= 0.12.7"
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
     }
    }
}