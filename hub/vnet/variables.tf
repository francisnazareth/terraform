variable "rg-location" {
   default= "nolocation"
}

variable "rg-name" {
   default= "noname"
}

variable "hub-prefix" {
   default= "changeme"
}

variable "customer-name" {
   default = "changeme"
}

#Address range for VNET
variable "hub-vnet-address-space" {
  description = "Hub vnet address Space"
  default = "10.105.0.0/22"
}

#Address range for the firewall subnet (1 - 64)
variable "firewall-subnet-address-space" {
  description = "Firewall subnet address space"
  default = "10.105.0.0/26"
}

#Address range for the application gateway subnet (65 - 128)
variable "appgw-subnet-address-space" {
  description = "Application gateway subnet address space"
  default = "10.105.0.64/26"
}

#Address range for the VNET Gateway Subnet (129 - 160)
variable "gateway-subnet-address-space" {
  description = "Gateway subnet address space"
  default = "10.105.0.128/27"
}

#Address range for the Azure Bastion Subnet (161 - 192)
variable "bastion-subnet-address-space" {
  description = "Bastion subnet address space"
  default = "10.105.0.160/27"
}

#Address range for the 1st management subnet (193 - 208)
variable "mgmt-subnet-1-address-space" {
  description = "Management subnet 1 address space"
  default = "10.105.0.192/28"
}

#Address range for the 2nd management subnet (209 - 224)
variable "mgmt-subnet-2-address-space" {
  description = "Management subnet 2 address space"
  default = "10.105.0.208/28"
}

#Address range for the shared services subnet (224 - 239)
variable "shared-svcs-snet-address-space" {
  description = "Shared services subnet address space"
  default = "10.105.0.224/28"
}
