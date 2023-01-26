

resource "azurerm_network_security_group" "f5-xc-peer-nsg" {
  name                = "f5_xc_peer_nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azureRegion
}


resource "azurerm_network_security_rule" "f5-xc-peer-nsg-rule" {
  name                        = "allow_trusted_peer"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix      = var.trusted_ip
  #source_address_prefixes     = local.auto_trusted_cidr
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.f5-xc-peer-nsg.name
}

resource "azurerm_network_security_rule" "f5-xc-peer-nsg-rule2" {
  name                        = "allow_trusted_peer2"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "100.64.0.0/10"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.f5-xc-peer-nsg.name
}


resource "azurerm_virtual_network" "f5-xc-peer" {
  name                = "f5_xc_spoke_vnet"
  location            = var.azureRegion
  address_space       = [var.spokeVnetAddressSpace]
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_subnet" "external-peer" {
  name                 = "external_subnet"
  virtual_network_name = azurerm_virtual_network.f5-xc-peer.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.spokeVnetExternalSubnet]
}

resource "azurerm_subnet" "internal-peer" {
  name                 = "internal_subnet"
  virtual_network_name = azurerm_virtual_network.f5-xc-peer.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.spokeVnetInternalSubnet]
}

resource "azurerm_subnet" "workload-peer" {
  name                 = "workload_subnet"
  virtual_network_name = azurerm_virtual_network.f5-xc-peer.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.spokeVnetWorkloadSubnet]
}

resource "azurerm_route_table" "workload-peer" {
  name                = "workload-peer_rt"
  location            = var.azureRegion
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "workload-peer" {
  subnet_id      = azurerm_subnet.workload-peer.id
  route_table_id = azurerm_route_table.workload-peer.id
}

resource "azurerm_subnet_network_security_group_association" "f5-xc-peer" {
  subnet_id                 = azurerm_subnet.external-peer.id
  network_security_group_id = azurerm_network_security_group.f5-xc-peer-nsg.id
}

resource "azurerm_virtual_network_peering" "toPeer" {
  name                      = "toPeer"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.f5-xc-hub.name
  remote_virtual_network_id = azurerm_virtual_network.f5-xc-peer.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "toHub" {
  name                      = "toHub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.f5-xc-peer.name
  remote_virtual_network_id = azurerm_virtual_network.f5-xc-hub.id
  allow_forwarded_traffic   = true
}
