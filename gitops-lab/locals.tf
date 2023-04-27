locals {
  xc_tenant_full             = format("%s-%s", var.xc_tenant, var.xc_tenant_suffix)
  project_prefix             = var.project_prefix
  build_suffix               = random_id.build_suffix.hex
  nginx_pull_secret_server   = var.nginx_pull_secret_server
  nginx_pull_secret_username = file(var.nginx_jwt)
  nginx_pull_secret_password = "none"
  argocd_fqdn                = format("%s-%s.%s", var.argo_host_prefix, var.namespace, var.lab_domain)
  argocd_k8s_service         = format("argocd-server.%s", var.namespace)
  grafana_fqdn               = format("%s-%s.%s", var.grafana_host_prefix, var.namespace, var.lab_domain)
  grafana_k8s_service        = format("grafana.%s", var.namespace)
  brewz_fqdn                 = format("%s-%s.%s", var.brewz_host_prefix, var.namespace, var.lab_domain)

  #XC LB
  apps = {
    argocd = {
      domain          = local.argocd_fqdn
      k8s_service     = local.argocd_k8s_service
      k8s_service_tls = true
      k8s_port        = 443
    },
    grafana = {
      domain          = local.grafana_fqdn
      k8s_service     = local.grafana_k8s_service
      k8s_service_tls = false
      k8s_port        = 80
    }
  }
}
