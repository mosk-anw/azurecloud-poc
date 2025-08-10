```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  description = "The prefix used for all resources"
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources should be created"
  type        = string
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                = "${var.prefix}-db01"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  administrator_login = "adminuser"
  administrator_password = "P@ssw0rd1234!"

  sku_name = "Standard_B1ms"
  storage_mb = 10240

  version = "13"

  depends_on = [azurerm_resource_group.main]
}

resource "azurerm_postgresql_flexible_server_configuration" "main" {
  name                = "backslash_quote"
  server_id           = azurerm_postgresql_flexible_server.main.id
  value               = "on"
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name     = "db01"
  server_id = azurerm_postgresql_flexible_server.main.id
}

output "postgresql_server_fqdn" {
  value = azurerm_postgresql_flexible_server.main.fqdn
}
```
