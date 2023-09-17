
# CREATING SERVICE PLAN FOR WEB APP API
resource "azurerm_service_plan" "api_service_plan" {
  name                = "${var.subdomain_prefix}_api_service_plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

# CREATING API WEB APP
resource "azurerm_linux_web_app" "api_web_app" {
  name                = "${var.subdomain_prefix}api"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.api_service_plan.id
  client_certificate_enabled = true

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = "Server=tcp:${azurerm_mssql_server.mssql_database_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.mssql_database.name};Persist Security Info=False;User ID=${azurerm_mssql_server.mssql_database_server.administrator_login};Password=${azurerm_mssql_server.mssql_database_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  site_config {
    application_stack{
    dotnet_version = var.dotnet_version
  }
  }

}






# CREATING SERVICE PLAN FOR WEB APP DM
resource "azurerm_service_plan" "dm_service_plan" {
  name                = "${var.subdomain_prefix}_dm_service_plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

# CREATING DM WEB APP
resource "azurerm_linux_web_app" "dm_web_app" {
  name                = "${var.subdomain_prefix}dm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.dm_service_plan.id
  client_certificate_enabled = true

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = "Server=tcp:${azurerm_mssql_server.mssql_database_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.mssql_database.name};Persist Security Info=False;User ID=${azurerm_mssql_server.mssql_database_server.administrator_login};Password=${azurerm_mssql_server.mssql_database_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  } 

  site_config {
    application_stack{
    dotnet_version = var.dotnet_version
  }
  }
}