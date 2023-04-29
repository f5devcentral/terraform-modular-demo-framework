locals {
  xc_tenant_full             = format("%s-%s", var.xc_tenant, var.xc_tenant_suffix)
  project_prefix             = var.project_prefix
  build_suffix               = random_id.build_suffix.hex
  brewz_fqdn                 = format("%s-%s.%s", var.brewz_host_prefix, var.namespace, var.lab_domain)
  tenant_ip_name             = jsondecode(data.http.get_public_ips.response_body).items[0].name
  namespaces                 = jsondecode(data.http.namespaces.response_body).items
  ns_exists                  = try(
                                index(local.namespaces.*.name, var.namespace) > 0 ? true : false,
                                false
                              )

  #XC LB
  apps = {
    brewz = {
      domain          = local.nrewz_fqdn
      k8s_service     = local.brewz_k8s_service
      k8s_service_tls = true
      k8s_port        = 443
    }
  }
}
