resource "azurerm_public_ip" "vnetgw-public-ip" {
  name                = "pip-vnetgw"
  location            = var.rg-location
  resource_group_name = var.rg-name
  allocation_method = "Dynamic"
}


resource "azurerm_virtual_network_gateway" "hub-vnet-gateway" {
  name                = "vgw-hub"
  location            = var.rg-location
  resource_group_name = var.rg-name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnetgw-public-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.vnetgw-snet-id
  }
}
