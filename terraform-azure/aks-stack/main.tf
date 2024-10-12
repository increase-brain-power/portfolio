terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
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
  resource_group_name = azurerm_resource_group.rg.name
  DBName = "aks-stack-db"
  location = var.location
}
