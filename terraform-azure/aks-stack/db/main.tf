locals {
  location_normalized = lower(replace(var.location, " ", ""))
  private_dns_zone_name = var.environment == "AzureUSGovernment" ? "${local.location_normalized}.private.mysql.database.usgovcloudapi.net" : "${local.location_normalized}.private.mysql.database.azure.com"
}

resource "azurerm_private_dns_zone" "mysql_private_dns" {
  name                = local.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_dns_link" {
  name                  = "link-to-vnet"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql_private_dns.name
  virtual_network_id    = var.virtual_network_id

  registration_enabled = false
  
  depends_on = [azurerm_private_dns_zone.mysql_private_dns]
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.database_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login    = var.database_username
  administrator_password = var.database_password

  sku_name = var.compute_size
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  delegated_subnet_id       = var.delegated_subnet_id
  private_dns_zone_id       = azurerm_private_dns_zone.mysql_private_dns.id

  storage {
    iops              = var.iops
    size_gb   = var.size_gb
  }

  version = var.mysql_version

  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.mysql_dns_link]
}

resource "azurerm_mysql_flexible_server_configuration" "mysql_config" {
  name                = "sql_generate_invisible_primary_key"
  value               = "OFF"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
}
