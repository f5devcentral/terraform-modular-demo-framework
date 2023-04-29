locals{
    secret_input_vars = merge(yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/ef.input.demo.yaml")),yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/gitops_lab_vars.demo.yaml")))
    secret_env_vars = yamldecode(sops_decrypt_file("${get_path_to_repo_root()}/ef.env.demo.yaml"))
}

remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "techx-tmdf"
    key            = "${get_env("TF_VAR_namespace")}/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    disable_bucket_update = true
  }
}

terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = local.secret_env_vars
    }
}

inputs = local.secret_input_vars  