variable "environment" {
  type        = string
  description = "Environment name (dev, stg, prod)"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_base_name" {
  type        = string
  description = "Base name for resource group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
