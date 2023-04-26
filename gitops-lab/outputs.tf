/* output "xc_lb_values" {
  value = volterra_http_loadbalancer.lb_https
} */

output "xc_namespace" {
  value = var.namespace
}

output "argocd_password" {
  value = data.kubernetes_secret.argocd_password.data.password
  sensitive = true
}
