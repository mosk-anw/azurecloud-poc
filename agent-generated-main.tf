terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.46"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mycluster01" {
  name     = "mycluster01"
  location = "uksouth"
}

module "aks_cluster" {
  source = "Azure/avm-res-containerservice-managedcluster/azurerm"
  version = "~> 0.2"

  name               = "myakscluster01"
  resource_group_name = azurerm_resource_group.mycluster01.name
  location            = azurerm_resource_group.mycluster01.location
  dns_prefix          = "myakscluster01"
  default_node_pool   = {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }
}