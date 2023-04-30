include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

include "gitops-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

terraform {
  before_hook "pre-check" {
    commands = ["apply", "plan"]
    execute  = ["./pre-check.sh"]
  }
}

dependencies {
  paths = ["../aws-appstack-kubeconfig", "../xc-re-vk8s-kubeconfig"]
}

dependency "xc_site" {
  config_path = "../aws-appstack-site-1"
}

dependency "mk8s_get_kubeconfig" {
  config_path = "../aws-appstack-kubeconfig"
}

dependency "vk8s_get_kubeconfig" {
  config_path = "../xc-re-vk8s-kubeconfig"
}

inputs = {
  instance_suffix        = "1"
  site_type              = dependency.xc_site.outputs.site_type
  site_name              = dependency.xc_site.outputs.site_name
  mk8s_kubeconfig_file   = dependency.mk8s_get_kubeconfig.outputs.kubeconfig_file
  vk8s_kubeconfig_file   = dependency.vk8s_get_kubeconfig.outputs.kubeconfig_file
}
