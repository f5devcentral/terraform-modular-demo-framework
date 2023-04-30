variable "xc_tenant" {
  type        = string
  description = "Volterra tenant name where the objects will be created."
}

variable "site_name" {
  type        = string
  description = "Your F5 XC vk8s site name"
}

variable "namespace" {
  type = string
}
variable volterra_token {
  type = string
}