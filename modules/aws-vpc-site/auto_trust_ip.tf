locals {
    auto_trusted_cidr = var.auto_trust_localip ? ["${jsondecode(data.http.myip[0].response_body).ip}/32"] : []
    # trusted CIDRs are a combination of CIDRs manually set through a tfvar
    # the CIDR of the VPC, and an automatically discovered CIDR if enabled
    # by auto_trust_localip
    trusted_cidr = concat([var.trusted_ip],local.auto_trusted_cidr)
}

variable "auto_trust_localip" {
  type        = bool
  default     = false
  description = "if true, query ifconfig.io for public ip of terraform host."
}
data http myip {
  count = var.auto_trust_localip ? 1 : 0
  url   = "https://ifconfig.io/all.json"
}