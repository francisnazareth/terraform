resource "azurerm_public_ip" "pip-firewall" {
  name                = "pip-azure-firewall"
  location            = var.hub-location
  resource_group_name = var.hub-rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "azure-ext-fw" {
  name                = "azure-ext-firewall"
  location            = var.hub-location
  resource_group_name = var.hub-rg

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub-firewall-subnet.id
    public_ip_address_id = azurerm_public_ip.pip-firewall.id
  }
}
