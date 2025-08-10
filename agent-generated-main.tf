```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "testrg"
  location = "UK South"
}

output "resource_group_id" {
  value = azurerm_resource_group.example.id
}
```