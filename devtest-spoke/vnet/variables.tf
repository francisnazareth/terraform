variable "devtest-prefix" {
  description = "DevTest resource prefix"
  default = "devtest"
}

variable "rg-location" { 
  default = "changeme"
}

variable "rg-name" {
  default = "changeme"
}

variable "customer-name" {
  default = "changeme"
}

variable "route-table-id" {
  default = "changeme"
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
