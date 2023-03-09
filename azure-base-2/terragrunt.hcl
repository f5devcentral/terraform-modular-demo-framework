include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-base.git?ref=v0.0.1"
}

inputs = {
  azureRegion                = "westus2"
  buildSuffix                = "env2"
  resourceGroup              = "f5demo_rg"
  location                   = "westus2"
  servicesVnetAddressSpace   = "100.64.64.0/20"
  servicesVnetExternalSubnet = "100.64.64.0/24"
  servicesVnetInternalSubnet = "100.64.65.0/24"
  servicesVnetWorkloadSubnet = "100.64.66.0/24"
  servicesVnetGatewaySubnet  = "100.64.67.0/24"
  spokeVnetAddressSpace      = "10.2.16.0/20"
  spokeVnetExternalSubnet    = "10.2.16.0/24"
  spokeVnetInternalSubnet    = "10.2.17.0/24"
  spokeVnetWorkloadSubnet    = "10.2.18.0/24"
}

dependencies {
  paths = []
}