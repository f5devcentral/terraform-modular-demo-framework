provider "kubernetes" {
  alias          = "mk8s"
  config_path    = var.mk8s_kubeconfig_file
  config_context = var.mk8s_kubeconfig_context
}

provider "kubectl" {
  alias          = "mk8s"
  config_path    = var.mk8s_kubeconfig_file
  config_context = var.mk8s_kubeconfig_context
  # load_config_file = false
}

resource "kubernetes_namespace" "student_namespace" {
  provider = kubernetes.mk8s
  metadata {
    name = var.namespace
  }
}

resource "kubectl_manifest" "microservices" {
  provider           = kubectl.mk8s
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.mk8s_manifests.documents)
  yaml_body          = each.value
  depends_on = [kubernetes_namespace.student_namespace]
}
