variable "namespace" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "useremail" {
  type = string
}

variable "vsite_ref_site_name" {
  type        = string
  description = "The virtual site reference for vk8s"
  #   default     = "us-re-all"
  default = "ves-io-all-res"
}

variable "vsite_ref_namespace" {
  type        = string
  description = "The namespace reference for vk8s"
  default     = "shared"
}
