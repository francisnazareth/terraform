variable "hub-location" {
  description = "Location of the hub components"
  default     = "westeurope"
}

variable "hub-vnet-resource-group" {
  description = "Hub Resource Group"
  default     = "hub-vnet-rg"
}

variable "hub-prefix" {
  description = "Hub resource prefix" 
  default = "hub"
}

variable "hub-vnet-address-space" { 
  description = "Hub vnet address Space"
  default = "10.105.0.0/22"
}

variable "gateway-subnet-address-space" {
  description = "Gateway subnet address space"
  default = "10.105.0.128/27"
}

variable "bastion-subnet-address-space" {
  description = "Bastion subnet address space"
  default = "10.105.0.160/27"
}

variable "firewall-subnet-address-space" {
  description = "Firewall subnet address space"
  default = "10.105.0.0/26"
}

variable "appgw-subnet-address-space" {
  description = "Application gateway subnet address space"
  default = "10.105.0.64/26"
}

variable "mgmt-subnet-1-address-space" {
  description = "Management subnet 1 address space"
  default = "10.105.0.192/28"
}

variable "mgmt-subnet-2-address-space" {
  description = "Management subnet 2 address space"
  default = "10.105.0.208/28"
}

variable "shared-svcs-snet-address-space" {
  description = "Shared services subnet address space"
  default = "10.105.0.224/28"
}

variable "firewall-resource-group" {
  description = "Firewall resource group"
  default = "rg-firewall"
}




