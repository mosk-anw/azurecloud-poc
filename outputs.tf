output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.demo.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.demo.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.demo.name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.demo.id
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.demo.primary_blob_endpoint
}
