variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "testrg"
}

variable "location" {
  description = "The location of the resource group."
  type        = string
  default     = "india"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "example-aks"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
  default     = "example"
}
