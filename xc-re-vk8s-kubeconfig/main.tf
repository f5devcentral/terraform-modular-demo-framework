data "http" "kubeconfig" {
  method = "POST"
  url    = format("https://%s.console.ves.volterra.io/api/web/namespaces/%s/api_credentials", var.namespace, var.xc_tenant, var.site_name)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.volterra_token)
  }
  request_body = jsonencode({
    name            = var.site_name
    namespaces      = var.namespace
    expiration_days = 30
    spec = {
      type                  = "KUBE_CONFIG"
      users                 = []
      password              = null
      virtual_k8s_name      = var.site_name
      virtual_k8s_namespace = var.namespace
    }
  })
}
locals {
  kubeconfig_location = "/home/ubuntu/xc-re-vk8s-kubeconfig"
}
resource "local_file" "kubeconfig" {
  filename = local.kubeconfig_location
  content  = data.http.kubeconfig.response_body
}

output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}
