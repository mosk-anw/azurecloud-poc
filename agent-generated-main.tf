provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "production-rg"
  location = "uksouth"
}