variable deploy_k8s_site {
    default = false
    description = "whether to deploy Distributed Cloud Mesh Networking for this cluster"
}
variable xc_sitetoken {
  description = "Distributed Cloud Site Token for site onboarding"
}
variable latitude {
  description = "Latitude of Distributed Cloud Site"
}
variable longitude {
  description = "Longitude of Distributed Cloud Site"
}
output deploy_k8s_site_instructions {
  value = var.deploy_k8s_site ? "LOG INTO XC CONSOLE AND APPROVE THE SITE REGISTRATION" : ""
}
variable "projectPrefix" {
  type = string
}
variable "instanceSuffix" {
  type = string
}

# resource local_file ce_k8s {
#     count = var.deploy_k8s_site ? 1 : 0
#     filename = "__ce_k8s_site.yaml"
#     content = templatefile("${path.module}/ce_k8s.yaml",{
#       clustername  = format("%s-gke-%s",var.projectPrefix,var.instanceSuffix)
#       latitude     = var.latitude
#       longitude    = var.longitude
#       xc_sitetoken = var.xc_sitetoken
#     })
# }

# resource local_file storageclass {
#     count = var.deploy_k8s_site ? 1 : 0
#     filename = "__ce_storageclass.yaml"
#     content = file("${path.module}/storageclass.yaml")
# }

# resource local_file pv {
#     count = var.deploy_k8s_site ? 1 : 0
#     filename = "__ce_pv.yaml"
#     content = file("${path.module}/pv.yaml")
# }

provider "kubernetes" {
  host     = format("https://%s",var.cluster_host)
  token                  = var.cluster_access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

locals{
  staticmanifestfiles = [
    "volterra-admin-role-binding.yaml",
    "vp-manager-statefulset.yaml",
    "vpm-role-binding.yaml",
    "vpm-sa.yaml",
    "serviceaccount.yaml",
    "volterra-admin-role.yaml",
    "vpm-role.yaml",
    "vpm-service.yaml",
    "ver-clusterrolebinding.yaml",
    "volterra-ce-init.yaml",
    "vpm-cluster-role.yaml",
    "vpm-sa-clusterrolebinding.yaml"
  ]
}
resource kubernetes_manifest namespace {
  manifest = yamldecode(file(format("%s/ce-manifests/%s",path.module,"namespace.yaml")))
}

resource kubernetes_manifest static_manifests {
  count = length(local.staticmanifestfiles)
  manifest = yamldecode(file(format("%s/ce-manifests/%s",path.module,local.staticmanifestfiles[count.index])))
  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.config
  ]
}
resource kubernetes_manifest config {
  manifest = yamldecode(templatefile("${path.module}/ce-manifests/vpm-cfg.yaml",{
      clustername  = format("%s-gke-%s",var.projectPrefix,var.instanceSuffix)
      latitude     = var.latitude
      longitude    = var.longitude
      xc_sitetoken = var.xc_sitetoken
    }))
}
resource kubernetes_manifest pv {
  count = 8
  manifest = yamldecode(templatefile("${path.module}/ce-manifests/pv.yaml",{
      pvname = format("pv%02d",count.index)
    }))
}


variable cluster_host {}
variable cluster_client_certificate {}
variable cluster_client_key {}
variable cluster_ca_certificate {}
variable cluster_access_token {}


