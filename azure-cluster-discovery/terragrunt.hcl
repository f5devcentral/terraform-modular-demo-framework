include "root" {
  path = find_in_parent_folders()
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
}

terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-discovered-cluster.git?ref=v0.1.0"
  before_hook "pre-check" {
      commands = ["apply","plan"]
      execute  = ["./pre-check.sh"]
  }
}


dependencies {
  paths = ["../azure-base-1","../azure-appstack-site"]
}

dependency "infrastructure" {
  config_path = "../azure-base-1"
}

dependency "xc_site" {
  config_path = "../azure-appstack-site"
}

inputs = {
  instance_suffix = "2"
  site_type       = dependency.xc_site.outputs.site_type
  site_name       = dependency.xc_site.outputs.site_name
  azure_region    = dependency.infrastructure.outputs.azure_region
  resource_group  = dependency.infrastructure.outputs.resource_group
}