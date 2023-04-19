provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}

provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config
  }
}

# Create a random id
resource "random_id" "build_suffix" {
  byte_length = 2
}
