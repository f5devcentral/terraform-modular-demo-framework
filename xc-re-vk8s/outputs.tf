output "site_name" {
  value = volterra_virtual_k8s.vk8s.name
}

output "namespace" {
  value = volterra_virtual_k8s.vk8s.namespace
}

output "vsite_ref_site_name" {
  value = volterra_virtual_k8s.vk8s.vsite_refs[0].name
}

output "vsite_ref_namespace" {
  value = volterra_virtual_k8s.vk8s.vsite_refs[0].namespace
}
