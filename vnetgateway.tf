resource "azurerm_public_ip" "vnetgw-public-ip" {
  name                = "vnetgw-public-ip"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group

  allocation_method = "Dynamic"
}


resource "azurerm_virtual_network_gateway" "ooredoo-vnet-gateway" {
  name                = "ooredoo-vnet-gateway"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnetgw-public-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
  }
}
