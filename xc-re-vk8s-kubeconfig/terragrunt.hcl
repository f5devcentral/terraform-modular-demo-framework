locals{
    secret_input_vars = merge(yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/ef.input.demo.yaml")),yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/gitops_lab_vars.demo.yaml")))
    secret_env_vars = yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/ef.env.demo.yaml"))
}

include "root" {
  path = find_in_parent_folders()
}

include "appstack-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

include "virtual-k8s" {
  path = find_in_parent_folders("virtual-k8s.hcl")
}


dependencies {
  paths = ["../xc-re-vk8s"]
}

dependency "xc_site" {
  config_path = "../xc-re-vk8s"
}
terraform {
  before_hook "pre-check" {
      commands = ["apply","plan"]
      execute  = ["./pre-check-vk8s.sh","${local.secret_input_vars.project_prefix}"]
  }
}

inputs = {
  site_name = dependency.xc_site.outputs.vk8s_site_name
}
