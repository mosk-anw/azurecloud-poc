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

resource "azurerm_kubernetes_cluster" "myaks01" {
  name                = "myaks01"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 10
    vm_size    = "Standard_DS2_v2"
    min_count  = 1
    max_count  = 15
    zones      = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
