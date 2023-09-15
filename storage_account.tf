
resource "azurerm_storage_account" "storage_account" {
  name                     = "companywebapp"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  account_kind = "StorageV2"
  static_website{
    index_document = "index.html"
    error_404_document = "index.html"
  }

  tags ={}
}

/*
resource "azurerm_dns_zone" "dns_zone" {
  name                = "sub-domain.domain.com"
  resource_group_name = azurerm_resource_group.resource_group.name
}

data "azurerm_storage_account" "storage_account" {
  name                = azurerm_storage_account.storage_account.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = azurerm_storage_account.storage_account.name
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_custom_domain" "frontdoor_custom_domain" {
  name                     = "customdomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  dns_zone_id              = azurerm_dns_zone.dns_zone.id
  host_name                = split("/", data.azurerm_storage_account.storage_account.primary_web_endpoint)[2] #"companywebapp.z13.web.core.windows.net"#data.azurerm_storage_account.companywebapp.primary_web_endpoint

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
  depends_on = [ azurerm_storage_account.storage_account ]
}
*/


resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = azurerm_storage_account.storage_account.name
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "Standard_AzureFrontDoor"

  response_timeout_seconds = 120

  tags = {
    environment = "example"
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_origin_group" {
  name                     = "frontdoor-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  session_affinity_enabled = false

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Http"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_endpoint" {
  name                     = "frontdoor-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  enabled                  = true
}

resource "azurerm_cdn_frontdoor_origin" "frontdoor_origin" {
  name                          = "frontdoor-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.frontdoor_origin_group.id
  enabled                       = true
  host_name                      = azurerm_storage_account.storage_account.primary_web_host
  origin_host_header             = azurerm_storage_account.storage_account.primary_web_host
  priority                       = 1
  weight                         = 500
  certificate_name_check_enabled = true
}




