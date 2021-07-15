output "vnet-name" {
 value = azurerm_virtual_network.hub-vnet.name
}

output "vnetgw-snet-id" {
   value = azurerm_subnet.hub-gateway-subnet.id
}

output "bastion-snet-id" {
  value = azurerm_subnet.hub-bastion-subnet.id
}

output "firewall-snet-id" {
   value = azurerm_subnet.hub-firewall-subnet.id
}

output "appgw-snet-id" {
   value = azurerm_subnet.hub-appgw-subnet.id
}

output "management-snet-1-id" {
  value = azurerm_subnet.hub-mgmt-subnet-01.id
}

output "management-snet-2-id" {
  value = azurerm_subnet.hub-mgmt-subnet-02.id
}

output "sharedsvc-snet-id" {
  value = azurerm_subnet.hub-sharedsvc-subnet-01.id
}