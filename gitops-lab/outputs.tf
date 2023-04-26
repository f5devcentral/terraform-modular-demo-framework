/* output "xc_lb_values" {
  value = volterra_http_loadbalancer.lb_https
} */

output "namespace" {
  value = var.namespace
}

output "volt_ic_namespace" {
  value = var.volt_ic_namespace
}

output "argocd_password" {
  value = data.kubernetes_secret.argocd_password.data.password
  sensitive = true
}
