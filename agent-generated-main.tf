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

resource "azurerm_resource_group" "aks_rg" {
  name     = "mytestaks666"
  location = "uksouth"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "mytestaks666"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    min_count  = 1
    max_count  = 5
  }

  dns_prefix = var.dns_prefix

  identity {
    type = "SystemAssigned"
  }
}
