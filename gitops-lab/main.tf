provider "volterra" {
}

provider "kubernetes" {
  config_path    = local_file.kubeconfig.filename
  config_context = var.site_name
}

provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
  }
}

# Create a random id
resource "random_id" "build_suffix" {
  byte_length = 2
}
