variable "mk8s_site_name" {
  type        = string
  description = "Your F5 XC AppStack site name"
}

variable "vk8s_site_name" {
  type        = string
  description = "Your F5 XC VirtualK8s site object name"
}

variable "volterra_token" {
  type        = string
  description = "Your F5 XC API token"
}

variable "brewz_host_prefix" {
  type        = string
  description = "The prefix to be used for the brewz site"
  default     = "brewz"
}

variable "lab_domain" {
  type        = string
  description = "The domain name for the lab"
  default     = "labs.f5demos.com"
}

variable "namespace" {
  type        = string
  description = "Volterra app namespace where the objects will be created. This cannot be system or shared ns."
}

variable "xc_tenant" {
  type        = string
  description = "Volterra tenant name where the objects will be created."
}

variable "xc_tenant_suffix" {
  type        = string
  description = "Volterra tenant suffix where the objects will be created."
}

variable "project_prefix" {
  type        = string
  description = "This value is inserted at the beginning of each XC object (alpha-numeric, no special character)"
}

variable "mk8s_kubeconfig_context" {
  type = string
}

variable "mk8s_kubeconfig_file" {
  type = string
}

variable "vk8s_kubeconfig_context" {
  type = string
}

variable "vk8s_kubeconfig_file" {
  type = string
}