include "root" {
  path = find_in_parent_folders()
}

terraform {
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
  site_type             = dependency.xc_site.outputs.site_type
  site_name             = dependency.xc_site.outputs.site_name
}