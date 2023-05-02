include "root" {
  path = find_in_parent_folders()
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
}

include "appstack-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

include "virtual-k8s" {
  path = find_in_parent_folders("virtual-k8s.hcl")
}

dependencies {
  paths = ["../aws-appstack-site-1"]
}

dependency "xc_site" {
  config_path = "../aws-appstack-site-1"
}

terraform {
  before_hook "pre-check" {
    commands = ["apply", "plan"]
    execute  = ["./pre-check.sh"]
  }
}

inputs = {
  site_name = dependency.xc_site.outputs.site_name
  site_type = dependency.xc_site.outputs.site_type
}
