include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/mjmenger/terraform-f5xc-site-mesh-group.git"
}

inputs = {}
