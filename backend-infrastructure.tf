# Backend Infrastructure Resources
# This file contains the Azure resources needed for Terraform remote state
# Deploy this FIRST before configuring remote state backend

# Development Environment Backend
resource "azurerm_resource_group" "terraform_state_dev" {
  name     = "rg-terraform-state-dev"
  location = "eastus"
  tags = {
    Purpose     = "terraform-state"
    Environment = "development"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_account" "terraform_state_dev" {
  name                     = "tfstatedev123"
  resource_group_name      = azurerm_resource_group.terraform_state_dev.name
  location                 = azurerm_resource_group.terraform_state_dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Purpose     = "terraform-state"
    Environment = "development"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_container" "terraform_state_dev" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state_dev.name
  container_access_type = "private"
}

# Staging Environment Backend
resource "azurerm_resource_group" "terraform_state_staging" {
  name     = "rg-terraform-state-staging"
  location = "eastus"
  tags = {
    Purpose     = "terraform-state"
    Environment = "staging"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_account" "terraform_state_staging" {
  name                     = "tfstatestaging123"
  resource_group_name      = azurerm_resource_group.terraform_state_staging.name
  location                 = azurerm_resource_group.terraform_state_staging.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Purpose     = "terraform-state"
    Environment = "staging"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_container" "terraform_state_staging" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state_staging.name
  container_access_type = "private"
}

# Production Environment Backend  
resource "azurerm_resource_group" "terraform_state_prod" {
  name     = "rg-terraform-state-prod"
  location = "eastus"
  tags = {
    Purpose     = "terraform-state"
    Environment = "production"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_account" "terraform_state_prod" {
  name                     = "tfstateprod123"
  resource_group_name      = azurerm_resource_group.terraform_state_prod.name
  location                 = azurerm_resource_group.terraform_state_prod.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # Higher redundancy for production

  tags = {
    Purpose     = "terraform-state"
    Environment = "production"
    ManagedBy   = "gitops-workflow"
  }
}

resource "azurerm_storage_container" "terraform_state_prod" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state_prod.name
  container_access_type = "private"
}
