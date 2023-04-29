provider "volterra" {
}

provider "kubernetes" {
  config_path    = var.kubeconfig_file
  config_context = var.site_name
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_file
  }
}

# Create a random id
resource "random_id" "build_suffix" {
  byte_length = 2
}
