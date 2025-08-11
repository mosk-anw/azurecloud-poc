variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 10
}

variable "vm_size" {
  description = "The size of the Virtual Machine for the nodes in the default node pool."
  type        = string
  default     = "Standard_DS2_v2"
}
