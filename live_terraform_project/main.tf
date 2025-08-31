terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test_clean" {
  name     = "rg-test-clean-e2e"
  location = "East US"
  
  tags = {
    Environment = "test"
    Purpose     = "e2e-testing"
    CreatedBy   = "DevOpsAI"
  }
}
