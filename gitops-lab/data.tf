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
    Authorization = format("APIToken %s", var.volterra_token)
  }
}

data "volterra_http_loadbalancer_state" "argocd_lb_state" {
  name       = "argocd"
  namespace  = var.namespace
  depends_on = [volterra_http_loadbalancer.lb_https]
}

data "http" "namespaces" {
  method = "GET"
  url    = format("https://%s.console.ves.volterra.io/api/web/namespaces", var.xc_tenant)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.volterra_token)
  }
  lifecycle {
    postcondition {
      condition = try(
                    index(jsondecode(self.response_body).items.*.name, var.namespace) > 0 ? true : false,
                    false
      )
      error_message = "Namespace does not exist"
    }
  }
}