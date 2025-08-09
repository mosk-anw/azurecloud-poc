# Terraform Backend Configuration
# This will be configured during the first terraform init

terraform {
  backend "azurerm" {
    # These values will be provided during terraform init
    # or via environment variables in GitHub Actions
    
    # resource_group_name  = "rg-terraform-state"
    # storage_account_name = "tfstate<unique_suffix>"
    # container_name       = "tfstate"
    # key                  = "infrastructure.tfstate"
  }
}
