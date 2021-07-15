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
    devtest-rg-name      = "rg-hub-01"
    devtest-rg-location  = "westeurope"
}

module "devtest-vnet" {
    source               = "./vnet"
    rg-name              = module.devtest-rg.rg-name
    rg-location          = module.devtest-rg.rg-location
    customer-name        = var.customer-name
}

module "virtualmachines" {
   source                = "./virtualmachines"
   rg-name               = module.devtest-rg.rg-name
   rg-location           = module.devtest-rg.rg-location
   app-subnet-id         = module.devtest-vnet.app-subnet-id
   depends_on            = [module.devtest-vnet]
}

