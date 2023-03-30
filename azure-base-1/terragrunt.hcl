include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}
terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-base.git?ref=v0.0.1"
}

inputs = {
  azureRegion                = "westus2"
  buildSuffix                = "env1"
  resourceGroup              = "f5demo_rg"
  location                   = "westus2"
  servicesVnetAddressSpace   = "100.64.16.0/20"
  servicesVnetExternalSubnet = "100.64.16.0/24"
  servicesVnetInternalSubnet = "100.64.17.0/24"
  servicesVnetWorkloadSubnet = "100.64.18.0/24"
  servicesVnetGatewaySubnet  = "100.64.67.0/24"
  spokeVnetAddressSpace      = "10.2.0.0/20"
  spokeVnetExternalSubnet    = "10.2.0.0/24"
  spokeVnetInternalSubnet    = "10.2.1.0/24"
  spokeVnetWorkloadSubnet    = "10.2.2.0/24"
}

dependencies {
  paths = []
}