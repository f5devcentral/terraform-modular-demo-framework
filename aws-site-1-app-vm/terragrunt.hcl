include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

terraform {
  source = "github.com/jeffgiroux/terraform-f5xc-aws-app-vm.git?ref=v0.0.2"
  before_hook "pre-check" {
      commands = ["apply","plan"]
      execute  = ["./pre-check.sh"]
  }
}

dependencies {
  paths = ["../aws-base-1","../aws-vpc-site-1"]
}

dependency "infrastructure" {
  config_path = "../aws-base-1"
}

dependency "xc_site" {
  config_path = "../aws-vpc-site-1"
}

inputs = {
  instanceSuffix       = "1"
  site_type            = dependency.xc_site.outputs.site_type
  site_name            = dependency.xc_site.outputs.site_name
  awsRegion            = dependency.infrastructure.outputs.awsRegion
  awsAz1               = dependency.infrastructure.outputs.awsAz1
  spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
  spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
  f5demo_app           = "text"
  f5demo_nodename      = "AWS Demo App Site-1"
  f5demo_color         = "ed7b0c"
}