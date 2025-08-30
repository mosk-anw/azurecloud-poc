# E2E GitOps Demo with Azure Verified Modules (AVM)
# This configuration creates a resource group and storage account using AVM modules

terraform {
  required_version = ">= 1.0"

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

# Azure Verified Module: Resource Group
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1.0"

  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    Project     = "gitops-e2e-demo"
    ManagedBy   = "terraform-avm"
    CreatedBy   = "devops-ai-agent"
    Purpose     = "e2e-testing"
  }
}

# Azure Verified Module: Storage Account
module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "~> 0.1.0"

  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enable secure defaults
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  # Disable public access for security
  public_network_access_enabled = false

  tags = {
    Environment = var.environment
    Project     = "gitops-e2e-demo"
    ManagedBy   = "terraform-avm"
    CreatedBy   = "devops-ai-agent"
    Purpose     = "e2e-testing"
    Tier        = "standard"
  }
}

# Optional: Create a blob container for testing
resource "azurerm_storage_container" "demo" {
  name                  = "demo-container"
  storage_account_name  = module.storage_account.name
  container_access_type = "private"

  depends_on = [module.storage_account]
}
