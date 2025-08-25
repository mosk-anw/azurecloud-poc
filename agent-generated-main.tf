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

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
}

module "aks_cluster" {
  source              = "Azure/avm-res-containerservice-managedcluster/azurerm"
  version             = "~> 0.2"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  dns_prefix          = "myakscluster"
  default_node_pool   = {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }
  name = "myakscluster"
}