terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.9"
    }
    aws = ">= 2.24"
  }
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}
resource "volterra_virtual_site" "virtual_site" {
  name      = format("%s-site-group", var.projectPrefix)
  namespace = "shared"

  site_selector {
    expressions = [format("site-group in (%s)", var.projectPrefix)]
  }

  site_type = "CUSTOMER_EDGE"
}

resource "volterra_site_mesh_group" "site-group" {
  name        = format("%s-site-group", var.projectPrefix)
  namespace   = "system"
  tunnel_type = "SITE_TO_SITE_TUNNEL_IPSEC"
  type        = "SITE_MESH_GROUP_TYPE_FULL_MESH"
  virtual_site {
    name = volterra_virtual_site.virtual_site.name
    namespace = "shared"
  }
}


