terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"

  name     = "e2etest"
  location = "North Europe"

  tags = var.tags
}
# Updated on Tue Sep  2 22:49:04 BST 2025
# Updated on Tue Sep  2 22:49:09 BST 2025
