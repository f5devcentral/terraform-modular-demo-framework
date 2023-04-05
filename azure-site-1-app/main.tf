resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.project_prefix}-aks"
  location            = var.azure_region
  resource_group_name = var.resource_group
  dns_prefix          = "${var.project_prefix}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = var.cluster_node_size
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.client_id_azurespn
    client_secret = var.client_id_password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}

variable client_id_azurespn {
    type = string 
    description = "clientID value for Azure SPN"
}

variable client_id_password {
    type = string
    description = "clientID password for Azure SPN"
}

variable project_prefix {
    type = string
    description = "custom project prefix from parent terragrunt.hcl"
}
variable azure_region {
    type = string
    description = "Azure Region for site deployment"
}
variable resource_group {
    type = string
    description = "Resource group for resources in Azure Site"
}
provider "azurerm" {
  features {}
}
variable cluster_node_size{
    type = string
    description = "Size of Nodes to be created for the AKS Node Pool"
    default = "Standard_B2s"
}
output kubeconfig {
    value = azurerm_kubernetes_cluster.default.kube_config_raw
    sensitive = true
}
variable instance_suffix {
    type = string
    description = "Suffix instance value that co-relates to site and app"
}
variable namespace {
    type = string
}
variable site_name {
    type = string
}

variable volterra_tenant {
    type = string
}
resource "volterra_discovery" "cluster-discovery" {
  name      = format("%s-aksdiscovery-%s",var.project_prefix,var.instance_suffix)
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