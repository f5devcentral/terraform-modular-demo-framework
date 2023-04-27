output "namespace" {
  value = var.namespace
}

output "volt_ic_namespace" {
  value = var.volt_ic_namespace
}

output "argocd_password" {
  value     = data.kubernetes_secret.argocd_password.data.password
  sensitive = true
}

output "argocd_lb_ip_address" {
  # value = jsondecode(data.http.get_public_ips.response_body).items[0].get_spec.ip
  value = "1.1.1.1"
}

output "xc_lb_lab_tls_secret_name" {
  value = var.xc_lb_lab_tls_secret_name
}

output "xc_tenant" {
  value = var.xc_tenant
}

output "xc_tenant_suffix" {
  value = var.xc_tenant_suffix
}
