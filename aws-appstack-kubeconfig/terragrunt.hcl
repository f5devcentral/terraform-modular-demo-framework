include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../aws-appstack-site-1"]
}

dependency "xc_site" {
  config_path = "../aws-appstack-site-1"
}

inputs = {
  site_name = dependency.xc_site.outputs.site_name
}
