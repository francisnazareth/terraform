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
    la-log-retention-in-days = var.la-log-retention-in-days
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
    hub-vnet-address-space           = var.hub-vnet-address-space
    firewall-subnet-address-space    = var.firewall-subnet-address-space
    appgw-subnet-address-space       = var.appgw-subnet-address-space
    gateway-subnet-address-space     = var.gateway-subnet-address-space
    bastion-subnet-address-space     = var.bastion-subnet-address-space
    mgmt-subnet-1-address-space      = var.mgmt-subnet-1-address-space
    mgmt-subnet-2-address-space      = var.mgmt-subnet-2-address-space
    shared-svcs-snet-address-space   = var.shared-svcs-snet-address-space
    hub-prefix           = var.hub-prefix
    customer-name        = var.customer-name
}


module "nsg"  {
    source         = "./nsg"
    rg-name        = module.hub-rg.rg-name
    rg-location    = module.hub-rg.rg-location
}

module "nic" {
    source               = "./nic"
    rg-name              = module.hub-rg.rg-name
    rg-location          = module.hub-rg.rg-location
    mgmt-snet-1-id       = module.hub-vnet.management-snet-1-id
    mgmt-snet-2-id       = module.hub-vnet.management-snet-2-id
    nsg-id               = module.nsg.nsg-id
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
   la-workspace-id       = module.laworkspace.la-workspace-id
   la-workspace-key      = module.laworkspace.la-workspace-key
   windows-admin-userid  = var.windows-admin-userid
   windows-admin-password  = var.windows-admin-password
   linux-admin-userid    = var.linux-admin-userid
   linux-admin-password  = var.linux-admin-password
   nic-linjumpserver1-id = module.nic.nic-linjumpserver1-id
   nic-winjumpserver1-id = module.nic.nic-winjumpserver1-id
   depends_on            = [module.hub-vnet]
}
