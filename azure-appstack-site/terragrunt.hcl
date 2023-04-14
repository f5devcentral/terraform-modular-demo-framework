include "root" {
  path = find_in_parent_folders()
}
include "azure" {
  path = find_in_parent_folders("azure.hcl")
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}
terraform {
  source = "github.com/piyerf5/terraform-f5xc-azure-appstack-site.git?ref=v0.1.0"
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
}

dependencies {
  paths = ["${get_path_to_repo_root()}//azure-base-1","${get_path_to_repo_root()}//mk8s-cluster-1"]
}

dependency "cluster" {
  config_path = "${get_path_to_repo_root()}/mk8s-cluster-1"
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}//azure-base-1"
  mock_outputs = {
    resourceGroup = "foo"
    hubVnetName = ""
  }
}

inputs = {
  instance_suffix       = "1"
  resource_group        = dependency.infrastructure.outputs.resource_group
  hub_vnet_name         = dependency.infrastructure.outputs.hub_vnet_name
  k8s_cluster_name      = dependency.cluster.outputs.k8s_cluster_name
  k8s_cluster_namespace = dependency.cluster.outputs.k8s_cluster_namespace
}
