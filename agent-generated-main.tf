```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-testapp"
  location = "UK South"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-testapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "testapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  app_settings = {
    "DATABASE_URL" = azurerm_postgresql_flexible_server.database.connection_string
  }
}

resource "azurerm_postgresql_flexible_server" "database" {
  name                   = "testapp-db"
  location               = azurerm_resource_group.rg.location
  resource_group_name    = azurerm_resource_group.rg.name
  administrator_login    = "psqladmin"
  administrator_password = "P@ssw0rd12345!"   # Change to a secure password
  sku_name               = "Standard_D4s_v3"
  version                = "12"

  storage_mb             = 32768

  delegated_subnet_id    = null
  private_dns_zone_id    = null

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_database" "db" {
  name                = "appdb"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_flexible_server.database.name
  collation           = "en_US.UTF8"
  charset             = "UTF8"
}
```