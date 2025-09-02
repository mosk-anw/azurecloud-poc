variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "testeurop"
}

variable "location" {
  description = "The location/region where the resources will be provisioned"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}