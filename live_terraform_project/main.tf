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

# Create Azure Resource Group
resource "azurerm_resource_group" "devops-agi-rg-01" {
  name     = "devops-agi-rg-01"
  location = "Central India"
  tags = {
    env = "test"
  }
}
