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
  source = "github.com/mjmenger/terraform-f5xc-azure-base.git?ref=v0.1.0rc2"
}

inputs = {
  azure_region                  = "westus2"
  instance_suffix               = "env1"
  resource_group                = "f5demo_rg"
  location                      = "westus2"
  services_vnet_address_space   = "100.64.16.0/20"
  services_vnet_external_subnet = "100.64.16.0/24"
  services_vnet_internal_subnet = "100.64.17.0/24"
  services_vnet_workload_subnet = "100.64.18.0/24"
  services_vnet_gateway_subnet  = "100.64.67.0/24"
  spoke_vnet_address_space      = "10.2.0.0/20"
  spoke_vnet_external_subnet    = "10.2.0.0/24"
  spoke_vnet_internal_subnet    = "10.2.1.0/24"
  spoke_vnet_workload_subnet    = "10.2.2.0/24"
}

dependencies {
  paths = []
}