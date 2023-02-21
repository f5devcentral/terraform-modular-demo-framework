include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/piyerf5/terraform-f5xc-azure-appstack-site.git"
}

dependencies {
  paths = ["${get_path_to_repo_root()}//azure-base-1"]
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}//azure-base-1"
  mock_outputs = {
    resourceGroup = "foo"
    hubVnetName = ""
  }
}

inputs = {
  instanceSuffix = "1"
  resourceGroup  = dependency.infrastructure.outputs.resourceGroup
  hubVnetName    = dependency.infrastructure.outputs.hubVnetName
}
