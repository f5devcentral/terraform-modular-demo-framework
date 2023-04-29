include "root" {
  path = find_in_parent_folders()
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
include "aws-base" {
  path = find_in_parent_folders("aws-base.hcl")
}

include "env-setup" {
  path = find_in_parent_folders("env-setup.hcl")
}

terraform {}

inputs = {}
