#Hub location
variable "hub-location" {
  description = "Location of the hub components"
  default     = "westeurope"
}

#Hub resource group name
variable "hub-rg" {
  description = "Hub Resource Group"
  default     = "rg-hub-01"
}
