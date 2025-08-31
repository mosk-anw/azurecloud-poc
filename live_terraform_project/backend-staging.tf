terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-staging"
    storage_account_name = "tfstatestaging123"
    container_name       = "tfstate"
    key                  = "staging/terraform.tfstate"
  }
}
