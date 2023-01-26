include "root" {
  path = find_in_parent_folders()
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
    resourceGroup = dependency.infrastructure.outputs.resourceGroup
    hubVnetName   = dependency.infrastructure.outputs.hubVnetName
}

