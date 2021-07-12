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
  address_prefixes     = [var.gateway-subnet-address-space]
}

resource "azurerm_subnet" "hub-bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.bastion-subnet-address-space]
}

resource "azurerm_subnet" "hub-firewall-subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.firewall-subnet-address-space]
}

resource "azurerm_subnet" "hub-appgw-subnet" {
  name                 = "snet-aag-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.appgw-subnet-address-space]
}


resource "azurerm_subnet" "hub-mgmt-subnet-001" {
  name                 = "snet-mgmt-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.mgmt-subnet-1-address-space]
}

resource "azurerm_subnet" "hub-mgmt-subnet-002" {
  name                 = "snet-mgmt-ooredoo-hub-we-002"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes       = [var.mgmt-subnet-2-address-space]
}

resource "azurerm_subnet" "hub-sharedsvc-subnet-001" {
  name                 = "snet-sharedsvc-ooredoo-hub-we-001"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes       = [var.shared-svcs-snet-address-space]
}

