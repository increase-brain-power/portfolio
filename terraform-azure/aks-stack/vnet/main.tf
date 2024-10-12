resource "azurerm_virtual_network" "vnet" {
  name                = var.VNETName
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.VNETAddressPrefix]
}

resource "azurerm_network_security_group" "privatesubnet_nsg" {
  name                = "${var.VNETName}-privatensg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "publicsubnet_nsg" {
  name                = "${var.VNETName}-publicnsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allowHTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = var.AppAllowFromCIDR == "Any-subnet" ? "*" : var.AppAllowFromCIDR
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "allowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = var.AppAllowFromCIDR == "Any-subnet" ? "*" : var.AppAllowFromCIDR
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "allowBackendAPI"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_subnet" "public_subnet" {
  name                 = var.PublicSubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.PublicSubnetAddressPrefix]
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg" {
  subnet_id = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.publicsubnet_nsg.id
}

resource "azurerm_subnet" "private_subnet" {
  name                 = var.PrivateSubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.PrivateSubnetAddressPrefix]
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg" {
  subnet_id = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.privatesubnet_nsg.id
}

resource "azurerm_subnet" "database_subnet" {
  name                 = var.databaseSubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.databaseSubnetAddressPrefix]

  delegation {
    name = "dbdelegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
    }
  }

  private_endpoint_network_policies = "Enabled"
  private_link_service_network_policies_enabled = "false"
}

resource "azurerm_subnet_network_security_group_association" "database_subnet_nsg" {
  subnet_id                 = azurerm_subnet.database_subnet.id
  network_security_group_id = azurerm_network_security_group.privatesubnet_nsg.id
}

# Outputs
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database_subnet.id
}

output "VirtualNetworkName" {
  value = azurerm_virtual_network.vnet.name
}

output "VirtualNetworkPublicSubnetName" {
  value = azurerm_subnet.public_subnet.name
}

output "VirtualNetworkPrivateSubnetName" {
  value = azurerm_subnet.private_subnet.name
}
