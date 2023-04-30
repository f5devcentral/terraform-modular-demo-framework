include "root" {
  path = find_in_parent_folders()
}

include "appstack-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

dependencies {
  paths = ["../xc-re-vk8s"]
}

dependency "xc_site" {
  config_path = "../xc-re-vk8s"
}

inputs = {
  site_name = dependency.xc_site.outputs.site_name
}
