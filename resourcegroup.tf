# THIS FILE WILL CREATE RESOURCE GROUP


# CREATING RESOURCE GROUP 
resource "azurerm_resource_group" "resource_group"{
    name = "${var.subdomain_prefix}.app"
    location = var.location
}