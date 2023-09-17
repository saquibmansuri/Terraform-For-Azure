terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}

provider "azurerm" {
  subscription_id = ""  # Can be found in subscriptions
  client_id       = ""    # Client id is the application ID
  client_secret   = "" # Client secret is inside Client credentials
  tenant_id       = "" # Tenant ID is directory ID 
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # This will destroy resource group even if it contains resources
    }
  }
}


