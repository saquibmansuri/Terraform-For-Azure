
resource "azurerm_mssql_server" "mssql_database_server" {
  name                         = "${var.subdomain_prefix}-server"
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  version                      = var.database_version
  administrator_login          = "${var.subdomain_prefix}-server-admin"
  administrator_login_password = var.database_password  # REQUIRED PARAMETER
}

resource "azurerm_mssql_database" "mssql_database" {
  name        = "${var.subdomain_prefix}-database"
  server_id   = azurerm_mssql_server.mssql_database_server.id
}
