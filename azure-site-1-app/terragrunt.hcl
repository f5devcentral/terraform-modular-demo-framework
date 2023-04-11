include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
terraform {
  before_hook "pre-check" {
      commands = ["apply","plan"]
      execute  = ["./pre-check.sh"]
  }

  extra_arguments "checktype" {
      commands = ["apply","plan"]
      arguments = []
      env_vars = {
          XCSITETYPES = "aws_vpc_sites"
      }
  }  
}


dependencies {
  paths = ["../azure-base-1","../azure-site-1"]
}

dependency "infrastructure" {
  config_path = "../azure-base-1"
}

dependency "xc_site" {
  config_path = "../azure-site-1"
}

inputs = {
  instance_suffix        = "1"
  site_type             = dependency.xc_site.outputs.site_type
  site_name             = dependency.xc_site.outputs.site_name
  azure_region           = dependency.infrastructure.outputs.azure_region
  resource_group         = dependency.infrastructure.outputs.resource_group  
}