variable "customer-name" {
  description = "Customer name"
  default = "changeme"
}

variable "hub-location" {
  description = "Location of the hub components"
  default     = "westeurope"
}

variable "hub-rg" {
  description = "Hub Resource Group"
  default     = "rg-hub-01"
}

variable "hub-prefix" {
  description = "Hub resource prefix" 
  default = "hub"
}

variable "hub-vnet-address-space" { 
  description = "Hub vnet address Space"
  default = "10.105.0.0/22"
}

#Address range for the Firewall subnet (1-63)
variable "firewall-subnet-address-space" {
  description = "Firewall subnet address space"
  default = "10.105.0.0/26"
}

#Address range for the application gateway subnet (64 - 127)
variable "appgw-subnet-address-space" {
  description = "Application gateway subnet address space"
  default = "10.105.0.64/26"
}

#Address range for the VNET gateway subnet (128 - 159)
variable "gateway-subnet-address-space" {
  description = "Gateway subnet address space"
  default = "10.105.0.128/27"
}

#Address range for the bastion subnet (160 - 191)
variable "bastion-subnet-address-space" {
  description = "Bastion subnet address space"
  default = "10.105.0.160/27"
}

#Address range for the management subnet 1 (192 - 207)
variable "mgmt-subnet-1-address-space" {
  description = "Management subnet 1 address space"
  default = "10.105.0.192/28"
}

#Address range for the management subnet 2 (208 - 223)
variable "mgmt-subnet-2-address-space" {
  description = "Management subnet 2 address space"
  default = "10.105.0.208/28"
}

#Address range for the shared services subnet (224 - 239)
variable "shared-svcs-snet-address-space" {
  description = "Shared services subnet address space"
  default = "10.105.0.224/28"
}
