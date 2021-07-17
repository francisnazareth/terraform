resource "azurerm_public_ip" "pip-firewall" {
  name                = "pip-azure-firewall"
  location            = var.rg-location
  resource_group_name = var.rg-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "azure-ext-fw" {
  name                = "fw-hub-ext"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall-snet-id
    public_ip_address_id = azurerm_public_ip.pip-firewall.id
  }
}
