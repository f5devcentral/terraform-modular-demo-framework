include "root" {
  path = find_in_parent_folders()
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
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
  site_name              = dependency.xc_site.outputs.site_name
}