terraform {
  required_version = ">= 0.14.0"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.21"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.42.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "~> 0.0"
    }
  }
}
