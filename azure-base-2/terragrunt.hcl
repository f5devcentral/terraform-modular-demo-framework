include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-base.git?ref=v0.1.0rc2"
}

inputs = {
  azure_region                  = "westus2"
  instance_suffix               = "env2"
  resource_group                = "f5demo_rg"
  location                      = "westus2"
  services_vnet_address_space   = "100.64.64.0/20"
  services_vnet_external_subnet = "100.64.64.0/24"
  services_vnet_internal_subnet = "100.64.65.0/24"
  services_vnet_workload_subnet = "100.64.66.0/24"
  services_vnet_gateway_subnet  = "100.64.67.0/24"
  spoke_vnet_address_space      = "10.2.16.0/20"
  spoke_vnet_external_subnet    = "10.2.16.0/24"
  spoke_vnet_internal_subnet    = "10.2.17.0/24"
  spoke_vnet_workload_subnet    = "10.2.18.0/24"
}

dependencies {
  paths = []
}