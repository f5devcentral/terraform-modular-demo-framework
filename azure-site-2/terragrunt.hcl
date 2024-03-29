include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
terraform {
  source = "github.com/f5devcentral/terraform-f5xc-azure-site.git?ref=v0.1.0//"
}

dependencies {
  paths = ["${get_path_to_repo_root()}//azure-base-2"]
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}//azure-base-2"
  mock_outputs = {
    resourceGroup = "foo"
    hubVnetName = ""
  }
}

inputs = {
  instance_suffix = "2"
  resource_group  = dependency.infrastructure.outputs.resource_group
  hub_vnet_name   = dependency.infrastructure.outputs.hub_vnet_name
}

