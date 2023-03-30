include "root" {
  path = find_in_parent_folders()
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}

 terraform {}

inputs = {
    instanceSuffix = "1"
}
