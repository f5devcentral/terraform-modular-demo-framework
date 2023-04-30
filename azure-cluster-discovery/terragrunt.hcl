include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
terraform {
  source = "github.com/piyerf5/terraform-f5xc-azure-discovered-cluster.git?ref=v0.1.0//"
  before_hook "pre-check" {
      commands = ["apply","plan"]
      execute  = ["./pre-check.sh"]
  }
}


dependencies {
  paths = ["../azure-base-2","../azure-site-2"]
}

dependency "infrastructure" {
  config_path = "../azure-base-2"
}

dependency "xc_site" {
  config_path = "../azure-site-2"
}

inputs = {
  instance_suffix = "2"
  site_type       = dependency.xc_site.outputs.site_type
  site_name       = dependency.xc_site.outputs.site_name
  azure_region    = dependency.infrastructure.outputs.azure_region
  resource_group  = dependency.infrastructure.outputs.resource_group
}