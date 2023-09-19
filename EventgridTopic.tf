# THIS FILE CREATES EVENT GRID TOPIC


# CREATING EVENT GRID SYSTEM TOPIC
resource "azurerm_eventgrid_system_topic" "eventgrid_topic" {
  name                   = "${var.subdomain_prefix}-topic"
  resource_group_name    = azurerm_resource_group.resource_group.name
  location               = azurerm_resource_group.resource_group.location
  source_arm_resource_id = azurerm_storage_account.storage_account.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}