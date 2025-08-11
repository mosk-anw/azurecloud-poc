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

resource "azurerm_resource_group" "example" {
  name     = "test123"
  location = "uksouth"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "exampleAKSCluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    min_count  = 1
    max_count  = 5
  }

  identity {
    type = "SystemAssigned"
  }
}
