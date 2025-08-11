variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "uksouth"
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the SQL database"
  type        = string
  default     = "mydb01"
}
