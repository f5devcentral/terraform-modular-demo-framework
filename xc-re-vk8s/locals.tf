locals {
  re_sites_list = [
    "ves-io-fr4-fra",
    "ves-io-me1-mel",
    "ves-io-ty8-tky",
    "ves-io-pa2-par",
    "ves-io-dc12-ash",
    "ves-io-hk2-hkg",
    "ves-io-tr2-tor",
    "ves-io-sy5-syd",
    "ves-io-md2-mad",
    "ves-io-ams9-ams",
    "ves-io-dal3-dal",
    "ves-io-wes-sea",
    "ves-io-ny8-nyc",
    "ves-io-tn2-lon",
    "ves-io-pa4-par",
    "ves-io-sif-che",
    "ves-io-os1-osa",
    "ves-io-mb2-mum",
    "ves-io-ls1-lis",
    "ves-io-sg3-sin",
    "ves-io-sv10-sjc"
  ]

  re_sites_random_index = random_id.index.dec % length(local.re_sites_list)

  random_re_site = local.re_sites_list[local.re_sites_random_index]

  site_selector = [format("ves.io/siteType = ves-io-re, ves.io/siteName = %s", local.random_re_site)]
}
