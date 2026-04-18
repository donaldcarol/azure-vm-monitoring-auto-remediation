output "resource_group_name" {

  value = azurerm_resource_group.rg.name

}

output "vnet_name" {

  value = azurerm_virtual_network.vnet.name

}

output "vnet_address_space" {

  value = azurerm_virtual_network.vnet.address_space

}