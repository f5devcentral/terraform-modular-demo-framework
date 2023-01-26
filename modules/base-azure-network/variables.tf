variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}

variable "azureRegion" {
  type        = string
  description = "target azure region"
}

variable "resourceGroup" {
  description = "The name of the resource group in which the virtual networks are created"
  default     = "f5demo_rg"
}

variable "trusted_ip" {
  description = "IP address of trusted source for mgmt/testing"
  default     = "192.0.2.10/32"
}
variable "servicesVnetAddressSpace" {
  default = "100.64.16.0/20"
}

variable "servicesVnetExternalSubnet" {
  default = "100.64.16.0/24"
}

variable "servicesVnetInternalSubnet" {
  default = "100.64.17.0/24"
}

variable "servicesVnetWorkloadSubnet" {
  default = "100.64.18.0/24"
}

variable "spokeVnetAddressSpace" {
  default = "10.2.0.0/20"
}

variable "spokeVnetExternalSubnet" {
  default = "10.2.0.0/24"
}

variable "spokeVnetInternalSubnet" {
  default = "10.2.1.0/24"
}

variable "spokeVnetWorkloadSubnet" {
  default = "10.2.2.0/24"
}
