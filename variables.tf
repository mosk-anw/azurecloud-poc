variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "myaks678"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "india"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "myaks678-cluster"
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "The size of the Virtual Machine instances in the AKS cluster."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
