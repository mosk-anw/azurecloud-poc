variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_base_name" {
  description = "Base name for resource group"
  type        = string
}
