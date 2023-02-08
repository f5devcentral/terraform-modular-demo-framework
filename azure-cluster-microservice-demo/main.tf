variable k8s_client_certificate {}
variable k8s_client_key {}
variable k8s_cluster_ca_certificate {}
variable k8s_host {}
variable k8s_app_manifest {
  type = string
  default = "https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml"
}

data http examplemanifest {
    url = var.k8s_app_manifest
}

provider kubectl {
  host                   = var.k8s_host
  client_certificate     = base64decode(var.k8s_client_certificate)
  client_key             = base64decode(var.k8s_client_key)
  cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  load_config_file       = false
}

data "kubectl_file_documents" "docs" {
    content = data.http.examplemanifest.response_body
}

resource "kubectl_manifest" "test" {
    for_each  = data.kubectl_file_documents.docs.manifests
    yaml_body = each.value
}


terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}