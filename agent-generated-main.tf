terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "myResourceGroup"
  location = "UK South"
}

resource "azurerm_kubernetes_cluster" "myakscluster" {
  name                = "myfirstaks555"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    zones      = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }
}