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
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "resource_group_base_name" {
  description = "Base name for resource group"
  type        = string
  default     = "devops-ai"
}
