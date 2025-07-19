resource "random_password" "postgres" {
  length  = 16
  special = true
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "consistlypg${random_integer.suffix.result}"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  administrator_login    = "pgadmin"
  administrator_password = random_password.postgres.result
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  version                = "13"
  zone                   = "1"
  delegated_subnet_id    = null
  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = "consistlydb"
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = "UTF8"
  collation = "en_US.utf8"
} 