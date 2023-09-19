# THIS FILES CONTAINS VARIABLE DEFINITIONS OF ALL VARIABLES USED IN THIS PROJECT


# MOST IMPORTANT VARIABLE, USED IN EVERY FILE
variable "subdomain_prefix" {
    type = string
}

######################################################################################

# USED IN provider.tf FILE
variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

########################################################################################

# USED IN resourcegroup.tf FILE
variable "location" {
  type = string
}

######################################################################################

# USED IN app_service.tf FILE
variable "app_os_type" {
    type = string
}

variable "app_sku_name" {
    type = string
}

variable "connection_string_name" {
  type   = string
}

variable "connection_string_type" {
  type   = string
}

variable "dotnet_version" {
  type = string
}

#######################################################################################

# USED IN db.tf FILE
variable "database_version" {
  type = string
}

########################################################################################

# USED IN storage_account.tf FILE
variable "storage_account_tier" {
  type = string
}

variable "storage_account_replication_type" {
  type = string
}

variable "storage_account_kind" {
  type = string
}

variable "static_website_index_document" {
  type = string
}

variable "static_website_error_document" {
  type = string
}

########################################################################################

# USED IN vnet.tf FILE
variable "vnet_cidr" {
  type = string
}

variable "subnet1_cidr" {
  type = string
}