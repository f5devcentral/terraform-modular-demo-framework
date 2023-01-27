terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source = "volterraedge/volterra"
    }
    aws = ">= 2.24"
  }
}
