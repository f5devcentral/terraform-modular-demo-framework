include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/jeffgiroux/terraform-f5xc-aws-app-vm.git?ref=v0.0.1"
}

dependencies {
  paths = ["../aws-base-1"]
}

dependency "infrastructure" {
  config_path = "../aws-base-1"
}

inputs = {
  instanceSuffix       = "1"
  awsRegion            = dependency.infrastructure.outputs.awsRegion
  awsAz1               = dependency.infrastructure.outputs.awsAz1
  spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
  spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
  f5demo_app           = "website"
  f5demo_nodename      = "Frontend (AWS)"
  f5demo_color         = "ed7b0c"
}