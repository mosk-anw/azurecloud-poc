terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.46"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "uksouth"
}

resource "azurerm_storage_account" "storage" {
  name                     = "teststorage01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "web" {
  name                  = "web"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
