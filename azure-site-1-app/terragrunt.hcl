include "root" {
  path = find_in_parent_folders()
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
  instanceSuffix        = "1"
  site_type             = dependency.xc_site.outputs.site_type
  site_name             = dependency.xc_site.outputs.site_name
  azureRegion           = dependency.infrastructure.outputs.azureRegion
  resourceGroup         = dependency.infrastructure.outputs.resourceGroup  
}