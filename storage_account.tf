
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.subdomain_prefix}webapp"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  public_network_access_enabled = true
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  static_website{
    index_document = "index.html"
    error_404_document = "index.html"
  }

  tags ={}
}



