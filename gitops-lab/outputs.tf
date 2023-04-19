/* output "XC_LB_VALUES" {
  value = volterra_http_loadbalancer.lb_https
} */

output "XC_NAMESPACE" {
  value = var.namespace
}

output "ARGOCD_PASSWORD" {
  value = data.kubernetes_secret.argocd_password.data.password
  sensitive = true
}
