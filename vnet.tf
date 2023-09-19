# THIS FILE CREATES A NETWORK RELATED RESOURCES


# CREATING A VIRTUAL NETWORK
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.subdomain_prefix}apiVnet"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["${var.vnet_cidr}"]
}

# CREATING 1 SUBNET
resource "azurerm_subnet" "subnet1" {
  name                 = "${var.subdomain_prefix}apiSubnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["${var.subnet1_cidr}"]
}

############################################################################

# CREATING DNS ZONE 1
resource "azurerm_private_dns_zone" "private_dns_zone1" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}

# CREATING DNS ZONE 2
resource "azurerm_private_dns_zone" "private_dns_zone2" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}

############################################################################

# CREATING PRIVATE ENDPOINT
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.subdomain_prefix}apiDbEndpoint"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.mssql_database_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
  
  private_dns_zone_group {
    name                 = "${var.subdomain_prefix}-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone1.id,azurerm_private_dns_zone.private_dns_zone2.id]
  }
}

############################################################################

# CREATING DNS ZONE VIRTUAL NETWORK LINK 
resource "azurerm_private_dns_zone_virtual_network_link" "database_dns_zone_link" {
  name                  = "${var.subdomain_prefix}-database-link"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone1.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}

# CREATING DNS ZONE VIRTUAL NETWORK LINK 
resource "azurerm_private_dns_zone_virtual_network_link" "redis_dns_zone_link" {
  name                  = "${var.subdomain_prefix}-redis-link"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone2.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}
