locals {
  xc_tenant_full    = format("%s-%s", var.xc_tenant, var.xc_tenant_suffix)
  project_prefix    = var.project_prefix
  build_suffix      = random_id.build_suffix.hex
  brewz_fqdn        = format("%s-%s.%s", var.brewz_host_prefix, var.namespace, var.lab_domain)
  brewz_k8s_service = format("brewz.%s", var.namespace)
  tenant_ip_name    = jsondecode(data.http.get_public_ips.response_body).items[0].name
  namespaces        = jsondecode(data.http.namespaces.response_body).items
  ns_exists = try(
    index(local.namespaces.*.name, var.namespace) > 0 ? true : false,
    false
  )

  #XC LB
  brewz_services = {
    spa = {
      k8s_service     = "spa"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 80
      outside_network = true
      vk8s_networks   = false
    },
    api = {
      k8s_service     = "api"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 8000
      outside_network = true
      vk8s_networks   = false
    },
    checkout = {
      k8s_service     = "checkout"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 8003
      outside_network = true
      vk8s_networks   = false
    },
    recommendations = {
      k8s_service     = "recommendations"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 8001
      outside_network = false
      vk8s_networks   = true
    },
    inventory = {
      k8s_service     = "inventory"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 8002
      outside_network = false
      vk8s_networks   = true
    }
  }

  brewz_routes = {
    "1" = {
      path = "/api/recommendations"
      k8s_service   = local.brewz_services.recommendations.k8s_service
      k8s_namespace = local.brewz_services.recommendations.k8s_namespace
      http_method   = "ANY"
    },
    "2" = {
      path = "/api/inventory"
      k8s_service   = local.brewz_services.inventory.k8s_service
      k8s_namespace = local.brewz_services.inventory.k8s_namespace
      http_method   = "ANY"
    },
    "3" = {
      path = "/checkout"
      k8s_service   = local.brewz_services.checkout.k8s_service
      k8s_namespace = local.brewz_services.checkout.k8s_namespace
      http_method   = "ANY"
    },
    "4" = {
      path = "/images"
      k8s_service   = local.brewz_services.api.k8s_service
      k8s_namespace = local.brewz_services.api.k8s_namespace
      http_method   = "GET"
    },
    "5" = {
      path = "/api"
      k8s_service   = local.brewz_services.api.k8s_service
      k8s_namespace = local.brewz_services.api.k8s_namespace
      http_method   = "ANY"
    },
    "6" = {
      path = "/"
      k8s_service   = local.brewz_services.spa.k8s_service
      k8s_namespace = local.brewz_services.spa.k8s_namespace
      http_method   = "ANY"
    },
  }
}
