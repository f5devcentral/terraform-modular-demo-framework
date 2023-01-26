variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}

variable "trusted_ip" {
  type        = string
  description = "IP to allow external access"
}

variable "namespace" {
  description = "Volterra application namespace"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "The DNS domain name that will be used as common parent generated DNS name of loadbalancers."
  default     = "shared.example.internal"
}

variable "awsRegion" {
  description = "aws region"
  type        = string
}

variable "awsAz1" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz2" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz3" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "volterraP12" {
  description = "Location of volterra p12 file"
  type        = string
  default     = null
}
variable "volterraUrl" {
  description = "url of volterra api"
  type        = string
  default     = null
}
variable "volterraTenant" {
  description = "Tenant of Volterra"
  type        = string
}
variable "volterraCloudCredAWS" {
  description = "Name of the volterra aws credentials"
  type        = string
}
variable "volterraCloudCredAzure" {
  description = "Name of the volterra aws credentials"
  type        = string
}
variable "servicesVpcCidrBlock" {
  type = string
}
variable "servicesVpc" {
  description = "Services VPC"
  type        = map(any)
}
variable "spokeVpcCidrBlock" {
}
variable "spokeVpc" {
  description = "Spoke VPC"
  type        = map(any)
}
variable "spoke2VpcCidrBlock" {
  type = string
}
variable "spoke2Vpc" {
  description = "Spoke VPC"
  type        = map(any)
}