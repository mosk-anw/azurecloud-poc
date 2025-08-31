terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "tfstateprod123"
    container_name       = "tfstate"
    key                  = "prod/terraform.tfstate"
  }
}
