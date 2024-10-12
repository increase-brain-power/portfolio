variable "resource_group_name" {
  description = "The name of the resource group where the VNet will be deployed."
  type        = string
}

variable "VNETName" {
  description = "VNET name where the application will be hosted"
  type        = string
  default     = "my-vnet"
}

variable "VNETAddressPrefix" {
  description = "Must be a valid IP CIDR range of the form x.x.x.x/x."
  type        = string
  default     = "10.0.0.0/20"
}

variable "PrivateSubnetName" {
  description = "Private subnet name"
  type        = string
  default     = "my-private-subnet"
}

variable "PrivateSubnetAddressPrefix" {
  description = "Must be a valid IP CIDR range of the form x.x.x.x/x."
  type        = string
  default     = "10.0.0.0/21"
}

variable "PublicSubnetName" {
  description = "Public subnet name"
  type        = string
  default     = "my-public-subnet"
}

variable "PublicSubnetAddressPrefix" {
  description = "Must be a valid IP CIDR range of the form x.x.x.x/x."
  type        = string
  default     = "10.0.8.0/24"
}

variable "databaseSubnetName" {
  description = "Database subnet name"
  type        = string
  default     = "my-database-subnet"
}

variable "databaseSubnetAddressPrefix" {
  description = "Must be a valid IP CIDR range of the form x.x.x.x/x."
  type        = string
  default     = "10.0.9.0/28"
}

variable "AppAllowFromCIDR" {
  description = "Trusted network (e.g. a VPN or corporate) CIDR range."
  type        = string
  default     = "Any-subnet"
}
