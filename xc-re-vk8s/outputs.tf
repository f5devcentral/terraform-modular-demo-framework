output "random_re_site" {
  value = local.random_re_site
}

output "virtual_site_name" {
  value = volterra_virtual_site.virtual_site.name
}

output "virtual_site_namespace" {
  value = volterra_virtual_site.virtual_site.namespace
}
