
# CREATING RESOURCE GROUP 
resource "azurerm_resource_group" "resource_group"{
    name = "companyapp"
    location = "East US"
}


resource "azurerm_service_plan" "api_service_plan" {
  name                = "api_service_plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# Creating an App Service
resource "azurerm_linux_web_app" "api_web_app" {
  name                = "uniquecompanyapi"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.api_service_plan.id
  client_certificate_enabled = true

  connection_string {
    name  = "CompanyDbContext"
    type  = "SQLAzure"
    value = "dummy"
  }

  site_config {
    application_stack{
    dotnet_version = "7.0"
  }
  }

}


resource "azurerm_service_plan" "dm_service_plan" {
  name                = "dm_service_plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# Creating an App Service
resource "azurerm_linux_web_app" "dm_web_app" {
  name                = "uniquecompanydm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.dm_service_plan.id
  client_certificate_enabled = true

  connection_string {
    name  = "CompanyDbContext"
    type  = "SQLAzure"
    value = "dummy"
  }

  site_config {
    application_stack{
    dotnet_version = "7.0"
  }
  }
}