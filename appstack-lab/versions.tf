terraform {
  required_version = ">= 0.14.0"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.21"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}
