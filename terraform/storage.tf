resource "azurerm_storage_account" "data" {
  name                     = "azureuberdata123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_name  = azurerm_storage_account.data.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "curated" {
  name                  = "curated"
  storage_account_name  = azurerm_storage_account.data.name
  container_access_type = "private"
}

