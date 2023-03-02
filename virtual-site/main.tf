resource "volterra_virtual_site" "sentence_ce_sto" {
  name      = format("%s-vs", var.projectPrefix)
  namespace = var.namespace

  site_selector {
    expressions = local.site_selector
  }
  site_type = "CUSTOMER_EDGE"
}
locals{
    site_selector = [var.site_selector]
}


