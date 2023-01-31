include "root" {
  path = find_in_parent_folders()
}

inputs = {
  instanceSuffix      = "2"
  region              = "us-west1"
  latitude            = "45.50871431992779"
  longitude           = "-122.61199851618468"
  network_subnet_cidr = "10.10.0.0/24"
  deploy_k8s_site     = false
}

