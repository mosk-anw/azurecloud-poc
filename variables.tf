variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myeks01"
}

variable "location" {
  description = "The Azure region where the resources will be deployed"
  type        = string
  default     = "ukwest"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "myaks"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
