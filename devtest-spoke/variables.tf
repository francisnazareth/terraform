variable "customer-name" {
  description = "Customer name"
  default = "changeme"
}

variable "devtest-location" {
  description = "Location of the devtest spoke components"
  default     = "westeurope"
}

variable "devtest-rg" {
  description = "DevTest Resource Group"
  default     = "rg-devtest-01"
}

variable "devtest-prefix" {
  description = "DevTest resource prefix"
  default = "devtest"
}

variable "devtest-vnet-address-space" {
  description = "DevTest vnet address Space"
  default = "10.20.0.0/22"
}

variable "app-subnet-address-space" {
  description = "Workload(VM) address space"
  default = "10.20.0.192/28"
}

variable "db-subnet-address-space" {
  description = "DB subnet address space"
  default = "10.20.0.208/28"
}

variable "firewall-ip"  {
  default= "changeme "
}
