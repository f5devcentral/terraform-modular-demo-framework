output "random_re_site" {
  value = local.random_re_site
}

output "vk8s_site_name" {
  value = volterra_virtual_k8s.vk8s.name
}

output "virtual_site_name" {
  value = volterra_virtual_site.virtual_site.name
}

output "virtual_site_namespace" {
  value = volterra_virtual_site.virtual_site.namespace
}
