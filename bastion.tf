resource "azurerm_public_ip" "bastion-pip" {
  name                = "bastion-pip"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-svc" {
  name                = "bastion-service"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub-bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}
