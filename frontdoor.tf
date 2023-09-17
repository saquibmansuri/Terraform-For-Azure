
resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = "${var.subdomain_prefix}-profile"
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "Standard_AzureFrontDoor"
  tags = {}
}

resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_origin_group" {
  name                     = "${var.subdomain_prefix}-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_endpoint" {
  name                     = "${var.subdomain_prefix}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  enabled                  = true
}

resource "azurerm_cdn_frontdoor_origin" "frontdoor_origin" {
  name                          = "${var.subdomain_prefix}-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.frontdoor_origin_group.id
  enabled                       = true
  certificate_name_check_enabled = true # Required Parameter
  host_name                      = azurerm_storage_account.storage_account.primary_web_host
  origin_host_header             = azurerm_storage_account.storage_account.primary_web_host
}
