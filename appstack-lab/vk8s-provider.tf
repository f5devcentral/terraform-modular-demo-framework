provider "kubectl" {
  alias          = "vk8s"
  config_path    = var.vk8s_kubeconfig_file
  config_context = var.vk8s_kubeconfig_context
  # load_config_file = false
}

resource "kubectl_manifest" "edge_services" {
  provider           = kubectl.vk8s
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.vk8s_manifests.documents)
  yaml_body          = each.value
}
