variable "environment" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "location" {
  type        = string
  description = "Azure region"
}