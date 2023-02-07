resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.projectPrefix}-aks"
  location            = var.azureRegion
  resource_group_name = var.resourceGroup
  dns_prefix          = "${var.projectPrefix}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = var.clusterNodeSize
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.clientID_azurespn
    client_secret = var.clientID_password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}

variable clientID_azurespn {
    type = string 
    description = "clientID value for Azure SPN"
}

variable clientID_password {
    type = string
    description = "clientID password for Azure SPN"
}

variable projectPrefix {
    type = string
    description = "custom project prefix from parent terragrunt.hcl"
}
variable azureRegion {
    type = string
    description = "Azure Region for site deployment"
}
variable resourceGroup {
    type = string
    description = "Resource group for resources in Azure Site"
}
provider "azurerm" {
  # subscription_id = "${var.subscription_id}"
  # client_id       = "${var.client_id}"
  # client_secret   = "${var.client_secret}"
  # tenant_id       = "${var.tenant_id}"
  features {}
}
variable clusterNodeSize{
    type = string
    description = "Size of Nodes to be created for the AKS Node Pool"
    default = "Standard_B2s"
}
output kubeconfig {
    value = azurerm_kubernetes_cluster.default.kube_config_raw
    sensitive = true
}
output k8s_host {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.host
  sensitive = true
}
output k8s_client_certificate {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
  sensitive = true
}
output k8s_client_key {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_key
  sensitive = true
}
output k8s_cluster_ca_certificate {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
  sensitive = true
}

resource local_file kubeconfig {
  filename = "${path.module}/kubeconfig.yaml"
  content  = azurerm_kubernetes_cluster.default.kube_config_raw
}
variable instanceSuffix {
    type = string
    description = "Suffix instance value that co-relates to site and app"
}
variable namespace {
    type = string
}
variable site_name {
    type = string
}

variable volterraTenant {
    type = string
}
resource "volterra_discovery" "cluster-discovery" {
  name      = format("%s-aksdiscovery-%s",var.projectPrefix,var.instanceSuffix)
  namespace = "system" // Always leave as "system" as Service Discovery objects are created under "System" namespace in XC

  // One of the arguments from this list "no_cluster_id cluster_id" must be set
  no_cluster_id = true

  description = format("Service discovery for AKS cluster %s", azurerm_kubernetes_cluster.default.name)
  
  discovery_k8s {
    access_info {
      kubeconfig_url {
        clear_secret_info {
          url = "string:///${base64encode(azurerm_kubernetes_cluster.default.kube_config_raw)}"
        }
      }
      isolated = true
    }
    publish_info {
      disable = true
    }
  }
  where {
    site {
      ref {
        name      = var.site_name
        namespace = "system" // Always leave as "system" as sites are created under "system" namespace on XC
      }
      network_type = "VIRTUAL_NETWORK_SITE_LOCAL_INSIDE"
    }
  }
}

terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source = "volterraedge/volterra"
     }
    }
}