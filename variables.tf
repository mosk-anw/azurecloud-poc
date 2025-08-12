variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
  default     = "india"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix to use for the AKS cluster."
  type        = string
  default     = "testak01"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
