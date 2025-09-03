resource "azurerm_resource_group" "main" {
  name     = "rg-${var.resource_group_base_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}
