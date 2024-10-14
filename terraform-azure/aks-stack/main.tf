terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.SUB_ID
  tenant_id       = var.TENANT_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.ResourceGroupBaseName}-rg"
  location = var.location
}

module "vnet" {
  source = "./vnet"
  resource_group_name = azurerm_resource_group.rg.name
  VNETName = "aks-stack-vnet"
  location = var.location
}

module "db" {
  source = "./db"
  environment = "AzureCloud"
  resource_group_name = azurerm_resource_group.rg.name
  database_server_name = "aks-stack-db"
  database_username = "aks_stack_admin"
  database_password = var.DB_PASSWORD
  virtual_network_id = module.vnet.vnet_id
  delegated_subnet_id = module.vnet.database_subnet_id
  location = var.location
}
