data "kubernetes_secret" "argocd_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
}

data "kubernetes_all_namespaces" "allns" {
  depends_on = [kubernetes_namespace.student_namespace, kubernetes_namespace.volt_ic_namespace]
}

data "http" "get_public_ips" {
  method = "GET"
  url    = format("https://%s.console.ves.volterra.io/api/config/namespaces/shared/public_ips?report_fields", var.xc_tenant)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.xc_sitetoken)
  }
}

data "volterra_http_loadbalancer_state" "argocd_lb_state" {
  name       = format("%s-xclb-%s-%s", local.project_prefix, "argocd", local.build_suffix)
  namespace  = var.namespace
  depends_on = [volterra_http_loadbalancer.lb_https]
}
