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
