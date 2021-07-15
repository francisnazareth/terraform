resource "azurerm_public_ip" "bastion-pip" {
  name                = "pip-bastion"
  location            = var.rg-location
  resource_group_name = var.rg-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-svc" {
  name                = "bastion-service"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion-snet-id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}
