variable "resource_group_base_name" {
  description = "Base name for resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
}
