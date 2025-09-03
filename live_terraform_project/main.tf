variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
    department  = "IT"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "example-resources"
  location = "East US"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                       = "kv-${var.keyvault_base_name}-${var.environment}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  tags = var.tags
}
