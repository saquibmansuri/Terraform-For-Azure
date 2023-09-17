# THIS FILE IS FOR FRONTDOOR CDN SETUP 


# CREATING FRONTDOOR PROFILE
resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = "${var.subdomain_prefix}-frontdoor-profile"
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "Standard_AzureFrontDoor"
  tags = {}
}

# CREATING FRONTDOOR ORIGIN GROUP
resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_origin_group" {
  name                     = "${var.subdomain_prefix}-frontdoor-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  #load balancing is a required block
  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

# CREATING FRONTDOOR ENDPOINT
resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_endpoint" {
  name                     = "${var.subdomain_prefix}-frontdoor-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  enabled                  = true
}

# CREATING FRONTDOOR ORIGIN
resource "azurerm_cdn_frontdoor_origin" "frontdoor_origin" {
  name                          = "${var.subdomain_prefix}-frontdoor-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.frontdoor_origin_group.id
  enabled                       = true
  certificate_name_check_enabled = true # Required Parameter
  host_name                      = azurerm_storage_account.storage_account.primary_web_host 
  origin_host_header             = azurerm_storage_account.storage_account.primary_web_host
}

# CREATING FRONTDOOR CUSTOM DOMAIN
resource "azurerm_cdn_frontdoor_custom_domain" "frontdoor_custom_domain" {
  name = "${var.subdomain_prefix}-frontdoor-custom-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  host_name = "${var.subdomain_prefix}.sentra.world" #IMPORTANT
  #tls block is required
  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

# CREATING FRONTDOOR RULE SET
resource "azurerm_cdn_frontdoor_rule_set" "frontdoor_rule_set" {
  name                     = "${var.subdomain_prefix}FrontdoorRuleSet" # spaces and hyphens are not allowed here
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
}

# CREATING FRONTDOOR ROUTE
resource "azurerm_cdn_frontdoor_route" "frontdoor_route" {
  name                          = "${var.subdomain_prefix}-frontdoor-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.frontdoor_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.frontdoor_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.frontdoor_origin.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.frontdoor_rule_set.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.frontdoor_custom_domain.id]
  link_to_default_domain          = false
}

# ASSOCIATING CUSTOM DOMAIN AND ROUTE
resource "azurerm_cdn_frontdoor_custom_domain_association" "frontdoor_custom_domain_association" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.frontdoor_custom_domain.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.frontdoor_route.id]
}