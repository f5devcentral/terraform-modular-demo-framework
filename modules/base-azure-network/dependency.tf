output projectPrefix {
  value = var.projectPrefix
}
output azureRegion {
  value = var.azureRegion
}
output resourceGroup {
  value =  azurerm_resource_group.rg.name
}
output hubVnetName {
  value = azurerm_virtual_network.f5-xc-hub.name
}
output workloadSubnet {
  value = azurerm_subnet.workload-peer.id
}