include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

terraform {
  source = "github.com/JeffGiroux/terraform-f5xc-aws-app-vm.git?ref=v0.1.0"
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
  instance_suffix         = "1"
  site_type               = dependency.xc_site.outputs.site_type
  site_name               = dependency.xc_site.outputs.site_name
  aws_region              = dependency.infrastructure.outputs.aws_region
  aws_az1                 = dependency.infrastructure.outputs.aws_az1
  spoke_workload_subnets  = dependency.infrastructure.outputs.spoke_workload_subnets
  spoke_security_group    = dependency.infrastructure.outputs.spoke_security_group
  f5demo_app              = "text"
  f5demo_nodename         = "AWS Demo App Site-1"
  f5demo_color            = "ed7b0c"
  num_worker_nodes_per_az = 0
}