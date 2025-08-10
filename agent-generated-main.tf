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

variable "prefix" {
  description = "The prefix used for all resources in this example."
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

resource "azurerm_cosmosdb_account" "ecomdb" {
  name                = "${var.prefix}ecomdb"
  location            = var.location
  resource_group_name = "${var.prefix}-rg"

  offer_type = "Standard"

  kind  = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }
}
```