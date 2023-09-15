terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}

provider "azurerm" {
  subscription_id = ""  #can be found in subscriptions
  client_id = ""    #Client id is the application ID
  client_secret = "" #client secret is inside Client credentials
  tenant_id = "" #tenant ID is directory ID 
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


