variable "xc_tenant" {
  type        = string
  description = "Volterra tenant name where the objects will be created."
}

variable "site_name" {
  type        = string
  description = "Your F5 XC AppStack site name"
}

variable "volterra_token" {
  type        = string
  description = "Your F5 XC API token"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to your kubeconfig file"
  default     = "/home/ubuntu/.kube/config"
}