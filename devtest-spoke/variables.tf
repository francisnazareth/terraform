variable "customer-name" {
  description = "Customer name"
  default = "ooredoo"
}

variable "devtest-location" {
  description = "Location of the devtest spoke components"
  default     = "westeurope"
}

variable "devtest-rg" {
  description = "DevTest Resource Group"
  default     = "rg-devtest-02"
}

variable "devtest-prefix" {
  description = "DevTest resource prefix"
  default = "devtest"
}

variable "client_secret" {
  default = "changeme"
}

variable "devtest-vnet-address-space" {
  description = "DevTest vnet address Space"
  default = "10.30.0.0/22"
}

variable "app-subnet-address-space" {
  description = "Workload(VM) address space"
  default = "10.30.0.192/28"
}

variable "db-subnet-address-space" {
  description = "DB subnet address space"
  default = "10.30.0.308/28"
}

variable "app-subnet-start-ip" { 
  default = "10.30.0.192"
}

variable "app-subnet-end-ip" { 
  default = "10.30.0.308"
}

variable "firewall-ip"  {
  default= "10.105.0.4"
}

variable "sql-server-name" {
  default="changme-sqlserver5465"
}

variable "sql-server-admin-user" {
  default = "sqladmin" 
}

variable "sql-server-admin-password" { 
  default = "Passw0rd123"
}

variable "linux-vm-admin-user" {
  default = "linadmin"
}

variable "linux-vm-admin-password" {
  default = "Passw0rd123!"
}

variable "la-workspace-id" {
  default = "e7572c85-ff27-481e-816d-611ca29e012c"
}

variable "la-workspace-key" {
  default = "Z3xB+mhgbKOsjGvjpVCWKg4AOiEAkGLW2BneOi0fiOXZrHJ82Tk8o9Y9L2W8Zkp8mjCmtOpPEOZk5AO4O2Z8Fw=="
}

variable "instrumentation-key" {
  default = "app insights instrumentation key"
}
