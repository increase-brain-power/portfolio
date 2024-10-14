variable "resource_group_name" {
  description = "Name of the resource group where the MySQL server will be deployed."
  type        = string
}

variable "location" {
  description = "Location for the resources."
  type        = string
}

variable "environment" {
  description = "The environment in which the resources are deployed (e.g., AzureCloud, AzureUSGovernment)."
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the virtual network where the MySQL Flexible Server will be deployed."
  type        = string
}

variable "mysql_version" {
  description = "MySQL version."
  type        = string
  default     = "8.0.21"
}

variable "database_server_name" {
  description = "The name of your Azure Database for MySQL Flexible Server."
  type        = string
}

variable "database_username" {
  description = "Database administrator username."
  type        = string
  default     = "admin"
}

variable "database_password" {
  description = "Database administrator password."
  type        = string
  sensitive   = true
}

variable "compute_size" {
  description = "Azure database for MySQL - Flexible Server SKU name."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "auto_grow_enabled" {
  description = "Storage auto-grow setting."
  type        = bool
  default     = "false"
}

variable "iops" {
  description = "Storage IOPS for the server."
  type        = number
  default     = 1000
}

variable "size_gb" {
  description = "Azure database for MySQL size (minimum recommended is 128GB)."
  type        = number
  default     = 20
}

variable "backup_retention_days" {
  description = "MySQL Server backup retention days."
  type        = number
  default     = 3
}

variable "geo_redundant_backup_enabled" {
  description = "Geo-redundant backup setting."
  type        = bool
  default     = "false"
}

variable "high_availability" {
  description = "High availability mode for a server."
  type        = string
  default     = "SameZone"
}

variable "delegated_subnet_id" {
  description = "ID of the subnet delegated to the MySQL Flexible Server."
  type        = string
}

