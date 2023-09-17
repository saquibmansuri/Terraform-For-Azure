# THIS FILE CONTAINS VALUES OF ALL VARIABLES USED IN THIS PROJECT


# MOST IMPORTANT, USED IN EVERY FILE
subdomain_prefix = "saquib" #enter company/client name

# VARIABLES USED IN resourcegroup.tf FILE
location = "East US"

# VARIABLES USED IN appservice.tf FILE
app_os_type = "Linux"
app_sku_name = "B1"
connection_string_name = "SentraDbContext"
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