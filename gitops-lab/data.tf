data "external" "api_p12" {
  program = ["sh", "get-p12-output.sh", "${var.api_p12_file}", "${var.api_p12_passphrase}"]
}

data "kubernetes_secret" "argocd_password" {
  metadata {
    name = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
}

data "kubernetes_all_namespaces" "allns" {}
