variable "rg-location" {
  default     = "westeurope"
}

variable "rg-name" {
  description = "DevTest Resource Group"
  default     = "rg-devtest-01"
}

variable "sql-server-name" {
  default     = "changeme"
}

variable "app-subnet-start-ip"{
  default     = "changeme"
}

variable "app-subnet-end-ip" {
  default     = "changeme"
}

variable "vnet-id" { 
  default = "changeme"
}

variable "db-subnet-id" { 
  default = "changeme"
}
