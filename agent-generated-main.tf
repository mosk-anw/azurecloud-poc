```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  description = "The prefix used for all resources in this example."
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_postgresql_server" "postgresql" {
  name                = "${var.prefix}-pgserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  administrator_login = "pgadmin"
  administrator_login_password = "H@Sh1CoR3!"
  version             = "11"
  sku_name            = "B_Gen5_2"
  storage_mb          = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = true
  public_network_access_enabled = true
  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

output "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgresql.name
}

output "postgresql_fully_qualified_domain_name" {
  description = "The FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgresql.fqdn
}
```