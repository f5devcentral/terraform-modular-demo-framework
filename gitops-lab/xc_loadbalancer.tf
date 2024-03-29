# Create XC LB config

resource "volterra_origin_pool" "op" {

  for_each = local.apps

  name        = each.key
  namespace   = var.namespace
  description = format("Origin pool pointing to origin server %s", each.value.k8s_service)
  origin_servers {
    k8s_service {
      service_name = each.value.k8s_service

      site_locator {
        site {
          tenant    = local.xc_tenant_full
          namespace = "system"
          name      = var.site_name
        }
      }
      outside_network = true
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

  for_each = local.apps

  name                            = each.key
  namespace                       = var.namespace
  description                     = format("HTTPS loadbalancer object for %s origin server", local.project_prefix)
  domains                         = [each.value.domain]
  advertise_on_public_default_vip = false
  advertise_on_public {
    public_ip {
      name      = local.tenant_ip_name
      namespace = "shared"
    }
  }
  default_route_pools {
    pool {
      name      = volterra_origin_pool.op[each.key].name
      namespace = var.namespace
    }
    weight = 1
  }
  routes {
    simple_route {
      http_method          = "ANY"
      disable_host_rewrite = true
      path {
        prefix = "/"
      }
      origin_pools {
        pool {
          name      = volterra_origin_pool.op[each.key].name
          namespace = var.namespace
        }
        weight = 1
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
