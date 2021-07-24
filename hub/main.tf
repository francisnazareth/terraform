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
}

module "hub-rg" {
    source         = "./rg"
    hub-rg         = var.hub-rg
    hub-location   = var.hub-location
}

module "diag-storage" {
    source         = "./storage"
    rg-name        = module.hub-rg.rg-name
    rg-location    = module.hub-rg.rg-location
    customer-name  = var.customer-name
}

module "laworkspace" {
    source         = "./laworkspace"
    rg-name        = module.hub-rg.rg-name
    rg-location    = module.hub-rg.rg-location
}

module "recovery-service-vault" {
   source          = "./recovery-service-vault"
   rg-name         = module.hub-rg.rg-name
   rg-location     = module.hub-rg.rg-location
}

module "keyvault" {
   source          = "./keyvault"
   rg-name         = module.hub-rg.rg-name
   rg-location     = module.hub-rg.rg-location
   customer-name   = var.customer-name
   soft-delete-retention-days = var.kv-softdelete-retention-days
}

module "hub-vnet" {
    source               = "./vnet"
    rg-name              = module.hub-rg.rg-name
    rg-location          = module.hub-rg.rg-location
    hub-prefix           = var.hub-prefix
    customer-name        = var.customer-name
}

module "bastion" {
    source               = "./bastion"
    rg-name              = module.hub-rg.rg-name
    rg-location          = module.hub-rg.rg-location
    bastion-snet-id      = module.hub-vnet.bastion-snet-id
    depends_on           = [module.hub-vnet]
}

module "appgw" {
   source                = "./application-gateway"
   rg-name               = module.hub-rg.rg-name
   rg-location           = module.hub-rg.rg-location
   vnet-name             = module.hub-vnet.vnet-name
   appgw-snet-id         = module.hub-vnet.appgw-snet-id
   depends_on            = [module.hub-vnet]
}

module "firewall" {
   source                = "./firewall"
   rg-name               = module.hub-rg.rg-name
   rg-location           = module.hub-rg.rg-location
   firewall-snet-id      = module.hub-vnet.firewall-snet-id
   depends_on            = [module.hub-vnet]
}

module "vnet-gw" {
   source                = "./vnet-gateway"
   rg-name               = module.hub-rg.rg-name
   rg-location           = module.hub-rg.rg-location
   vnetgw-snet-id        = module.hub-vnet.vnetgw-snet-id
   depends_on            = [module.hub-vnet]
}

module "virtualmachines" {
   source                = "./virtualmachines"
   rg-name               = module.hub-rg.rg-name
   rg-location           = module.hub-rg.rg-location
   mgmt-snet-1-id        = module.hub-vnet.management-snet-1-id
   mgmt-snet-2-id        = module.hub-vnet.management-snet-2-id
   windows-admin-userid  = var.windows-admin-userid
   windows-admin-password  = var.windows-admin-password
   linux-admin-userid    = var.linux-admin-userid
   linux-admin-password  = var.linux-admin-password
   depends_on            = [module.hub-vnet]
}
