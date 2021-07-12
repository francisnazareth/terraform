resource "azurerm_public_ip" "ooredoo-firewall-ip" {
  name                = "azure-firewall-pip"
  location            = var.hub-location
  resource_group_name = var.firewall-resource-group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "ooredoo-fw" {
  name                = "ooredoo-firewall"
  location            = var.hub-location
  resource_group_name = var.firewall-resource-group

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub-firewall-subnet.id
    public_ip_address_id = azurerm_public_ip.ooredoo-firewall-ip.id
  }
}
