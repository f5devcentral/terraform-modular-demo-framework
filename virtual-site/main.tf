resource "volterra_virtual_site" "sentence_ce_sto" {
  name      = format("%s-vs", var.projectPrefix)
  namespace = var.namespace

  site_selector {
    expressions = local.site_selector
  }
  site_type = "CUSTOMER_EDGE"
}
locals{
    site_selector = [format("site_group in (%s)",var.projectPrefix)]
}
terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source = "volterraedge/volterra"
    }
  }
}
variable projectPrefix {}
variable namespace {}
