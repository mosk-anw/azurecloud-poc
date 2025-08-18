variable "admin_username" {
  description = "The admin username for the Linux VM."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for the Linux VM."
  type        = string
}

variable "common_tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {
    environment = "production"
    project     = "web-hosting"
  }
}
