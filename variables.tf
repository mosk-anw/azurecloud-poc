variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aksperf12345"
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix to use with the AKS cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 10
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
