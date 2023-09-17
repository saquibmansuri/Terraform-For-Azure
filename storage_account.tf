# THIS FILE WILL CREATE STORAGE ACCOUNT


# CREATING STORAGE ACCOUNT
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.subdomain_prefix}webapp"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  public_network_access_enabled = true
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind = var.storage_account_kind
  static_website{
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_document
  }

  tags ={}
}



