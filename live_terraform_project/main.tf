terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.46"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "my_resource_group" {
  name     = "my-resource-group-uk-south"
  location = "UK South"
  tags     = var.tags
}
