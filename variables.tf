variable "ssh_public_key" {
  description = "The SSH public key for the VM."
  type        = string
}

variable "environment" {
  description = "The environment tag for the resources."
  type        = string
  default     = "development"
}
