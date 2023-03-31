include "root" {
  path = find_in_parent_folders()
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}

 terraform {}

inputs = {
    instance_suffix = "1"
}
