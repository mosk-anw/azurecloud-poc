# Generated Terraform Configuration
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

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-dev-cloudassist"
  location = "East US"
  
  tags = {
    Environment = "dev"
    CreatedBy   = "CloudAssist"
    Project     = "Infrastructure"
  }
}

# Outputs
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "location" {
  value = azurerm_resource_group.main.location
}
