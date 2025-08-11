variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource group should be created."
  type        = string
  default     = "eastus"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}
