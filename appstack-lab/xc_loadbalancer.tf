provider "volterra" {
}

# Create XC LB config

resource "volterra_origin_pool" "op" {

  for_each = local.brewz_services

  name        = each.key
  namespace   = each.value.k8s_namespace
  description = format("Origin pool pointing to origin server %s", each.value.k8s_service)
  origin_servers {
    k8s_service {
      service_name = format("%s.%s", each.value.k8s_service, each.value.k8s_namespace)

      site_locator {
        dynamic "site" {
          for_each = !each.value.vk8s_networks ? [1] : []
          content {
            tenant    = local.xc_tenant_full
            namespace = "system"
            name      = var.mk8s_site_name
          }
        }

        dynamic "virtual_site" {
          for_each = each.value.vk8s_networks ? [1] : []
          content {
            tenant    = local.xc_tenant_full
            namespace = var.virtual_site_namespace
            name      = var.virtual_site_name
          }
        }
      }
      outside_network = each.value.outside_network
      vk8s_networks   = each.value.vk8s_networks
    }
  }

  dynamic "use_tls" {
    for_each = each.value.k8s_service_tls ? [1] : []
    content {
      skip_server_verification = true
      tls_config {
        default_security = true
      }
    }
  }
  no_tls                 = !each.value.k8s_service_tls
  port                   = each.value.k8s_port
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
}

resource "volterra_http_loadbalancer" "lb_https" {
  name                            = var.brewz_host_prefix
  namespace                       = var.namespace
  description                     = format("HTTPS loadbalancer object for %s origin server", local.project_prefix)
  domains                         = [local.brewz_fqdn]
  advertise_on_public_default_vip = false
  advertise_on_public {
    public_ip {
      name      = local.tenant_ip_name
      namespace = "shared"
    }
  }
  dynamic "routes" {
    for_each = local.brewz_routes
    content {
      simple_route {
        http_method          = routes.value.http_method
        disable_host_rewrite = true
        path {
          prefix = routes.value.path
        }
        origin_pools {
          pool {
            name      = format("%s", volterra_origin_pool.op[routes.value.k8s_service].name)
            namespace = routes.value.k8s_namespace
          }
          weight = 1
        }
      }
    }
  }
  https {
    http_redirect = false
    add_hsts      = false
    tls_cert_params {
      tls_config {
        default_security = true
      }
      no_mtls = true
      certificates {
        name      = "wildcard-labs-f5demos-com"
        namespace = "shared"
      }
    }
  }
}
