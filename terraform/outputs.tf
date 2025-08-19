# Outputs for Azure Kubernetes Service (AKS)
# Following Azure Verified Module patterns

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "cluster_endpoint" {
  description = "Endpoint for the AKS cluster API server"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw Kubernetes configuration file content"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kubelet_identity" {
  description = "Kubelet identity information"
  value = {
    client_id                 = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
    object_id                 = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    user_assigned_identity_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].user_assigned_identity_id
  }
}

output "system_assigned_identity" {
  description = "System assigned identity of the AKS cluster"
  value = {
    principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
    tenant_id    = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
  }
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.aks.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.aks.id
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.aks.id
}

output "azure_portal_cluster_url" {
  description = "URL to view the AKS cluster in Azure Portal"
  value       = "https://portal.azure.com/#@/resource${azurerm_kubernetes_cluster.aks.id}/overview"
}
