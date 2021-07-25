# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
   }

  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = var.client_secret
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}

module "devtest-rg" {
    source               = "./rg"
    devtest-rg-name      = var.devtest-rg
    devtest-rg-location  = var.devtest-location
}

module "devtest-nsg" {
    source               = "./nsg"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
}

module "devtest-vnet" {
    source               = "./vnet"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
    route-table-id       = module.route-table.route-table-id
    devtest-vnet-address-space    = var.devtest-vnet-address-space
    app-subnet-address-space      = var.app-subnet-address-space
    db-subnet-address-space       = var.db-subnet-address-space
    customer-name        = var.customer-name
}

#module "devtest-vnet-pering" {
#    source               = "./vnet-peering"
#    rg-name              = module.devtest-rg.rg-name
#    rg-location          = module.devtest-rg.rg-location
#    devtest-vnet-name    = module.devtest-vnet.vnet-name
#    devtest-vnet-id      = module.devtest-vnet.vnet-id
#    hub-vnet-name        = "vnet-hub-${var.devtest-location}-01"
#    hub-vnet-id          = "/subscriptions/68a21693-1bbf-4db6-9aa3-f332ff4aab20/resourceGroups/rg-hub-01/providers/Microsoft.Network/virtualNetworks/vnet-hub-westeurope-01"
#}

module "route-table" {
    source               = "./route-table"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
    firewall-private-ip  = var.firewall-ip
}

module "nic" {
    source               = "./nic"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
    app-subnet-id        = module.devtest-vnet.app-subnet-id
    nsg-id               = module.devtest-nsg.nsg-id
}

module "sqlserver" {
    source              = "./sqlserver"
    rg-name             = module.devtest-rg.rg-name
    rg-location         = module.devtest-rg.rg-location
    vnet-id             = module.devtest-vnet.vnet-id
    db-subnet-id        = module.devtest-vnet.db-subnet-id
    app-subnet-start-ip = var.app-subnet-start-ip
    app-subnet-end-ip   = var.app-subnet-end-ip
}

module "virtualmachines" {
   source                = "./virtualmachines"
   rg-name               = module.devtest-rg.rg-name
   rg-location           = module.devtest-rg.rg-location
   nic-linsvr1-id        = module.nic.nic-linsvr1-id
   sql-server-name       = module.sqlserver.sql-server-name
   sql-user              = module.sqlserver.sql-user
   sql-password          = module.sqlserver.sql-password
   depends_on            = [module.devtest-vnet, module.sqlserver]
}
