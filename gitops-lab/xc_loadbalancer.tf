# Create XC LB config

resource "volterra_origin_pool" "op" {

  for_each = local.apps

  name        = format("%s-xcop-%s-%s", local.project_prefix, each.key, local.build_suffix)
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

  name                            = format("%s-xclb-%s-%s", local.project_prefix, each.key, local.build_suffix)
  namespace                       = var.namespace
  description                     = format("HTTPS loadbalancer object for %s origin server", local.project_prefix)
  domains                         = [each.value.domain]
  advertise_on_public_default_vip = true
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
  https_auto_cert {
    add_hsts              = false
    http_redirect         = true
    no_mtls               = true
    enable_path_normalize = true
    tls_config {
      default_security = true
    }
  }
}
