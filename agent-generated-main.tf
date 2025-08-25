provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "uksouth"
}

resource "azurerm_postgresql_server" "example" {
  name                = "mydb01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  administrator_login = "myadmin"
  administrator_login_password = "P@ssw0rd1234!"
  ssl_enforcement_enabled = true
  version = "11"
}