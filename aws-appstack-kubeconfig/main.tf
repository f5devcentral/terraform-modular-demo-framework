data "http" "kubeconfig" {
  method = "POST"
  url    = format("https://%s.console.ves.volterra.io/api/web/namespaces/system/sites/%s/global-kubeconfigs", var.xc_tenant, var.site_name)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.volterra_token)
  }
  request_body = jsonencode({
    expiration_timestamp = timeadd(timestamp(), "720h") # 30 days
    site                 = var.site_name
  })
}
locals {
  kubeconfig_location = var.kubeconfig_path
}
resource "local_file" "kubeconfig" {
  filename = local.kubeconfig_location
  content  = data.http.kubeconfig.response_body
}

output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}
