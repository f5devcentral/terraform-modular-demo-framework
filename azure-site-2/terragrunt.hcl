include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-site.git?ref=v0.0.1"
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
  instanceSuffix = "2"
  resourceGroup  = dependency.infrastructure.outputs.resourceGroup
  hubVnetName    = dependency.infrastructure.outputs.hubVnetName
}

