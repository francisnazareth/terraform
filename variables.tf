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
  description = "Hub VNET Address Space"
  default = "10.105.0.0/22"
}
