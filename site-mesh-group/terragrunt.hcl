include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
terraform {
  source = "github.com/mjmenger/terraform-f5xc-site-mesh-group.git?ref=v0.1.0"
}

inputs = {}
