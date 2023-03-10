include "root" {
  path = find_in_parent_folders()
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

terraform {
  source = "github.com/piyerf5/cluster-microservices-demo.git?ref=v0.0.1"
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

