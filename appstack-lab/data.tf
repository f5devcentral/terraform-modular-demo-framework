data "http" "get_public_ips" {
  method = "GET"
  url    = format("https://%s.console.ves.volterra.io/api/config/namespaces/shared/public_ips?report_fields", var.xc_tenant)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.volterra_token)
  }
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

data "kubectl_path_documents" "mk8s_manifests" {
    pattern = "${path.module}/manifests/mk8s/*.yaml"
}

data "kubectl_path_documents" "vk8s_manifests" {
    pattern = "${path.module}/manifests/vk8s/*.yaml"
}
