# THIS FILE WILL CREATE MSSQL AZURE DATABASE


# CREATING A RANDOM PASSWORD FOR THE DATABASE SERVER
resource "random_password" "database_password" {
  length  = 16
  upper   = true
  lower   = true
  numeric = true
  special = true
  override_special = "!$%&*"
}


# DISPLAYING THE RANDOM PASSWORD AS AN OUTPUT, COMMENT THE BLOCK IF NOT REQUIRED
output "database_password" {
  value       = random_password.database_password.result
  sensitive   = true
  description = "Generated SQL Database Password"
}
# RUN THIS COMMAND TO SEE THE OUTPUT - terraform output database_password


# CREATING MSSQL DATABASE SERVER
resource "azurerm_mssql_server" "mssql_database_server" {
  name                         = "${var.subdomain_prefix}-server"
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  version                      = var.database_version
  administrator_login          = "${var.subdomain_prefix}-server-admin"
  administrator_login_password = random_password.database_password.result  # REQUIRED PARAMETER
}

# CREATING MSSQL AZURE DATABASE
resource "azurerm_mssql_database" "mssql_database" {
  name        = "${var.subdomain_prefix}-database"
  server_id   = azurerm_mssql_server.mssql_database_server.id
}
