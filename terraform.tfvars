# THIS FILE CONTAINS VALUES OF ALL VARIABLES USED IN THIS PROJECT


# MOST IMPORTANT, USED IN EVERY FILE
subdomain_prefix = "saquib" #enter company/client name

# USED IN provider.tf FILE
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""

# VARIABLES USED IN resourcegroup.tf FILE
location = "East US"

# VARIABLES USED IN appservice.tf FILE
app_os_type = "Linux"
app_sku_name = "B1"
connection_string_name = "DbContext" # Put the value according to your usecase
connection_string_type = "SQLAzure"
dotnet_version = "7.0"

# VARIABLES USED IN db.tf FILE 
database_version = "12.0"

# VARIABLES USED IN storage_account.tf FILE
storage_account_tier = "Standard"
storage_account_replication_type = "LRS"
storage_account_kind = "StorageV2"
static_website_index_document = "index.html"
static_website_error_document = "index.html"

# VARIABLES USED IN vnet.tf FILE
vnet_cidr = "10.0.0.0/16"
subnet1_cidr = "10.0.1.0/24"