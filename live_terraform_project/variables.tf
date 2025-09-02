variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
