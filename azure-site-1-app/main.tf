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
    value = azurerm_kubernetes_cluster.default.kube_config.0
    sensitive = true
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
  namespace = var.namespace

  // One of the arguments from this list "no_cluster_id cluster_id" must be set
  no_cluster_id = true

  // One of the arguments from this list "discovery_k8s discovery_consul" must be set

  discovery_k8s {
    access_info {
      // One of the arguments from this list "kubeconfig_url connection_info in_cluster" must be set

      connection_info {
        api_server = azurerm_kubernetes_cluster.default.kube_config.0.host

        tls_info {
          ca_certificate_url {
            blindfold_secret_info_internal {
              location            = "string:///${azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate}"
            }
            // One of the arguments from this list "blindfold_secret_info vault_secret_info clear_secret_info wingman_secret_info" must be set

          }

          certificate = "value"

          certificate_url {
            blindfold_secret_info_internal {
              location            = "string:///${azurerm_kubernetes_cluster.default.kube_config.0.client_certificate}"
            }

            // One of the arguments from this list "wingman_secret_info blindfold_secret_info vault_secret_info clear_secret_info" must be set
      
          }

          key_url {
            blindfold_secret_info_internal {
              location            = "string:///${azurerm_kubernetes_cluster.default.kube_config.0.client_key}"
            }
                        
          }

          server_name    = split(":",azurerm_kubernetes_cluster.default.kube_config.0.host)[0]
        //  trusted_ca_url = "value"
        }
      }

      // One of the arguments from this list "isolated reachable" must be set
      isolated = true
    }

    publish_info {
      // One of the arguments from this list "disable publish publish_fqdns dns_delegation" must be set
      disable = true
    }
  }
  where {
    // One of the arguments from this list "site virtual_site virtual_network" must be set

    site {
       disable_internet_vip = true

      ref {
        name      = var.site_name
        namespace = var.namespace
        tenant    = var.volterraTenant
      }
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