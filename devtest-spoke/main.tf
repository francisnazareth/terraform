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

module "devtest-rg" {
    source               = "./rg"
    devtest-rg-name      = "rg-devtest-01"
    devtest-rg-location  = "westeurope"
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
    customer-name        = var.customer-name
}

module "nic" {
    source               = "./nic"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
    app-subnet-id        = module.devtest-vnet.app-subnet-id
    nsg-id               = module.devtest-nsg.nsg-id
}

module "virtualmachines" {
   source                = "./virtualmachines"
   rg-name               = module.devtest-rg.rg-name
   rg-location           = module.devtest-rg.rg-location
   nic-linsvr1-id        = module.nic.nic-linsvr1-id
   depends_on            = [module.devtest-vnet]
}

