provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "uksouth"
}

resource "azurerm_postgresql_server" "example" {
  name                = "testdb01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B_Gen5_1"
  version             = "11"
  ssl_enforcement_enabled = true
  storage_mb          = 5120
  administrator_login = "myadmin"
  administrator_login_password = "P@ssw0rd"
}