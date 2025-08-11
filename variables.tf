variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
  default     = "eastasia"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix to use with the AKS cluster."
  type        = string
  default     = "test456"
}
