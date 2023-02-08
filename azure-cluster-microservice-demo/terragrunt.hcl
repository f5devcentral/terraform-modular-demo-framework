include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../azure-cluster-discovery"]
}

dependency "cluster" {
  config_path = "../azure-cluster-discovery"
}

inputs = {
  kubeconfig                 = dependency.cluster.outputs.kubeconfig
  k8s_host                   = dependency.cluster.outputs.k8s_host
  k8s_client_certificate     = dependency.cluster.outputs.k8s_client_certificate
  k8s_client_key             = dependency.cluster.outputs.k8s_client_key
  k8s_cluster_ca_certificate = dependency.cluster.outputs.k8s_cluster_ca_certificate
}

