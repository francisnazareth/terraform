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

############################ KEY VAULT ########################
variable "kv-softdelete-retention-days" {
  type = number
  default = 7
}

############################ VNET & SUBNETS ###################
#Address space for HUB VNET
variable "hub-vnet-address-space" { 
  default = "10.105.0.0/22"
}

#Address range for the Firewall subnet (1-63)
variable "firewall-subnet-address-space" {
  default = "10.105.0.0/26"
}

#Address range for the application gateway subnet (64 - 127)
variable "appgw-subnet-address-space" {
  default = "10.105.0.64/26"
}

#Address range for the VNET gateway subnet (128 - 159)
variable "gateway-subnet-address-space" {
  default = "10.105.0.128/27"
}

#Address range for the bastion subnet (160 - 191)
variable "bastion-subnet-address-space" {
  default = "10.105.0.160/27"
}

#Address range for the management subnet 1 (192 - 207)
variable "mgmt-subnet-1-address-space" {
  default = "10.105.0.192/28"
}

#Address range for the management subnet 2 (208 - 223)
variable "mgmt-subnet-2-address-space" {
  default = "10.105.0.208/28"
}

#Address range for the shared services subnet (224 - 239)
variable "shared-svcs-snet-address-space" {
  default = "10.105.0.224/28"
}

###################### JUMP SERVERS (WINDOWS & LINUX) #######
variable "windows-admin-userid" {
  default = "adminuser"
}

variable "windows-admin-password" { 
  default = "P@$$w0rd1234!"
}

variable "linux-admin-userid" { 
  default = "adminuser"
}

variable "linux-admin-password" {
  default = "P@$$w0rd1234!"
}

################ LOG ANALYTICS WORKSPACE ##################

variable "la-log-retention-in-days" {
  type   =  number
  default =  30
}
