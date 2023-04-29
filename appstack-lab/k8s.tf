resource "kubernetes_namespace" "student_namespace" {
  metadata {
    name = var.namespace
  }
}
