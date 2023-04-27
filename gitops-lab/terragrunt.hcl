include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

terraform {
  before_hook "pre-check" {
    commands = ["apply", "plan"]
    execute  = ["./pre-check.sh"]
  }
}

dependencies {
  paths = ["../aws-appstack-site-1"]
}

dependency "infrastructure" {
  config_path = "../aws-base-1"
}

dependency "xc_site" {
  config_path = "../aws-appstack-site-1"
}

dependency "cluster" {
  config_path = "${get_path_to_repo_root()}/mk8s-cluster-1"
}

inputs = {
  instance_suffix        = "1"
  site_type              = dependency.xc_site.outputs.site_type
  site_name              = dependency.xc_site.outputs.site_name
  aws_region             = dependency.infrastructure.outputs.aws_region
  aws_az1                = dependency.infrastructure.outputs.aws_az1
  spoke_workload_subnets = dependency.infrastructure.outputs.spoke_workload_subnets
  spoke_security_group   = dependency.infrastructure.outputs.spoke_security_group
  k8s_cluster_name       = dependency.cluster.outputs.k8s_cluster_name
}