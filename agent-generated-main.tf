provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "testrg786"
  location = "uksouth"
}