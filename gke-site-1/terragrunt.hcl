include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["${get_path_to_repo_root()}//gke-base-1"]
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}//gke-base-1"
}

inputs = {
  instanceSuffix             = "2"
  region                     = "us-west1"
  latitude                   = "45.50871431992779"
  longitude                  = "-122.61199851618468"
  network_subnet_cidr        = "10.10.0.0/24"
  deploy_k8s_site            = true
  cluster_host               = dependency.infrastructure.outputs.kubernetes_cluster_host
  cluster_client_certificate = dependency.infrastructure.outputs.kubernetes_client_certificate
  cluster_client_key         = dependency.infrastructure.outputs.kubernetes_client_key
  cluster_ca_certificate     = dependency.infrastructure.outputs.kubernetes_ca_certificate
  cluster_access_token       = dependency.infrastructure.outputs.kubernetes_access_token
}