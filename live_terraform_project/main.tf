terraform {
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

# Create Azure Resource Group using AVM module
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"

  name     = var.resource_group_name
  location = var.location
  
  tags = {
    environment = var.environment
    created_by  = "DevOps-AI-Agent"
    test_type   = "e2e-avm-validation"
  }
}

# Output the resource group information
output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = module.resource_group.resource_id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.resource_group.name
}
