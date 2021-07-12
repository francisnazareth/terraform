resource "azurerm_resource_group" "hub-vnet-rg" {
  name     = var.hub-vnet-resource-group
  location = var.hub-location
}

resource "azurerm_virtual_network" "hub-vnet" {
  name                = "${var.hub-prefix}-vnet"
  location            = azurerm_resource_group.hub-vnet-rg.location
  resource_group_name = azurerm_resource_group.hub-vnet-rg.name
  address_space       = [var.hub-vnet-address-space]

  tags = {
    environment = "hub-spoke"
  }
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.105.0.128/27"]
}

resource "azurerm_subnet" "hub-bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.105.0.160/27"]
}

resource "azurerm_subnet" "hub-firewall-subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.105.0.0/26"]
}

resource "azurerm_subnet" "hub-appgw-subnet" {
  name                 = "snet-aag-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.105.0.64/26"]
}


resource "azurerm_subnet" "hub-mgmt-subnet-001" {
  name                 = "snet-mgmt-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes       = ["10.105.0.192/28"]
}

resource "azurerm_subnet" "hub-mgmt-subnet-002" {
  name                 = "snet-mgmt-ooredoo-hub-we-002"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes       = ["10.105.0.208/28"]
}

resource "azurerm_subnet" "hub-sharedsvc-subnet-001" {
  name                 = "snet-sharedsvc-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes       = ["10.105.0.224/27"]
}

