```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "testrg" {
  name     = "testrg"
  location = "UK South"
}

output "resource_group_id" {
  value = azurerm_resource_group.testrg.id
}
```