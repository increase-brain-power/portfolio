variable "SUB_ID" {
  description = "Azure Subscription ID"
  type        = string
}

variable "TENANT_ID" {
  description = "Azure Tenant ID"
  type        = string
}

variable "CLIENT_ID" {
  description = "Azure Client ID"
  type        = string
}

variable "CLIENT_SECRET" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "ResourceGroupBaseName" {
  description = "Resource group base name"
  type        = string
  default     = "aks-stack"
}

variable "location" {
  description = "Location for the resources."
  type        = string
  default     = "East US2"
}

variable "DB_PASSWORD" {
  description = "Database password"
  type        = string
  sensitive   = true
}
