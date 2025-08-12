variable "region_name" {
  type        = string
  description = "The Azure region name"
  default     = "centralindia"
}

variable "dns_prefix" {
  type        = string
  description = "The DNS prefix for the AKS cluster"
  default     = "testak01"
}
