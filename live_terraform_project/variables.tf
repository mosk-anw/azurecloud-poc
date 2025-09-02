variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}