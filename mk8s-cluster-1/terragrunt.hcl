include "root" {
  path = find_in_parent_folders()
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}

 terraform {
#   source = "github.com/mjmenger/terraform-f5xc-site-mesh-group.git"
 }

inputs = {
    instanceSuffix = "1"
}
