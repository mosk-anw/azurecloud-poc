terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "testak01" {
  name     = "testak01"
  location = var.region_name
}

resource "azurerm_kubernetes_cluster" "testak01" {
  name                = "testak01"
  location            = azurerm_resource_group.testak01.location
  resource_group_name = azurerm_resource_group.testak01.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    zones      = ["1", "2", "3"]
    min_count  = 1
    max_count  = 5
  }

  identity {
    type = "SystemAssigned"
  }
}
