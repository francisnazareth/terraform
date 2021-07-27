resource "azurerm_route_table" "rt-hub-firewall" {
  name                          = "rt-hub-firewall"
  location                      = var.rg-location
  resource_group_name           = var.rg-name
  disable_bgp_route_propagation = false

  route {
    name                        = "route_internal_traffic_in_vnet"
    address_prefix              = var.devtest-vnet-address-space
    next_hop_type               = "VnetLocal"
  }

  route {
    name                        = "route_all_traffic_to_fw"
    address_prefix              = "0.0.0.0/0"
    next_hop_type               = "VirtualAppliance"
    next_hop_in_ip_address      = var.firewall-private-ip
  }

  tags = {
    environment = "DevTest"
  }
}

