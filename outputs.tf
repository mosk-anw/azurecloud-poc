# Output values for the GitOps demo infrastructure

output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = module.resource_group.resource_id
}

output "storage_account_name" {
  description = "Name of the created storage account"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "ID of the created storage account"
  value       = module.storage_account.resource_id
}

output "demo_container_name" {
  description = "Name of the demo storage container"
  value       = azurerm_storage_container.demo.name
}
