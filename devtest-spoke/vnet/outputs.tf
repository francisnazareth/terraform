output "vnet-name" {
   value = azurerm_virtual_network.devtest-vnet.name
}

output "vnet-id" { 
   value = azurerm_virtual_network.devtest-vnet.id
}

output "app-subnet-id" {
   value = azurerm_subnet.spoke-app-subnet-01.id
}
