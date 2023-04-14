include "root" {
  path = find_in_parent_folders()
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
include "aws-base" {
  path = find_in_parent_folders("aws-base.hcl")
}
dependencies {
  paths = ["${get_path_to_repo_root()}/aws-setup"]
}
terraform {}

inputs = {}
