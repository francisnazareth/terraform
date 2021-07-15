output "vnet-name" {
 value = azurerm_virtual_network.devtest-vnet.name
}

output "app-subnet-id" {
   value = azurerm_subnet.spoke-app-subnet-001.id
}
