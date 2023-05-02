include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
}

terraform {
  before_hook "pre-check" {
    commands = ["apply", "plan"]
    execute  = ["./pre-check.sh", "${dependency.get_kubeconfig.outputs.kubeconfig_file}"]
  }
}

dependencies {
  paths = ["../aws-appstack-kubeconfig", "../aws-appstack-site-1"]
}

dependency "xc_site" {
  config_path = "../aws-appstack-site-1"
}

dependency "get_kubeconfig" {
  config_path = "../aws-appstack-kubeconfig"
}

inputs = {
  instance_suffix        = "1"
  site_type              = dependency.xc_site.outputs.site_type
  site_name              = dependency.xc_site.outputs.site_name
  kubeconfig_file        = dependency.get_kubeconfig.outputs.kubeconfig_file
}