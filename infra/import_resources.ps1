# Import existing Azure resources into Terraform state

# Container Registry
terraform import azurerm_container_registry.main "/subscriptions/865d39b1-0123-4c0a-97b1-b584ee4a1445/resourceGroups/consistly-rg/providers/Microsoft.ContainerRegistry/registries/consistlyacr58260"

# Log Analytics Workspace
terraform import azurerm_log_analytics_workspace.main "/subscriptions/865d39b1-0123-4c0a-97b1-b584ee4a1445/resourceGroups/consistly-rg/providers/Microsoft.OperationalInsights/workspaces/consistlylaw58260"

# PostgreSQL Flexible Server
terraform import azurerm_postgresql_flexible_server.main "/subscriptions/865d39b1-0123-4c0a-97b1-b584ee4a1445/resourceGroups/consistly-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/consistlypg58260"

# PostgreSQL Database
terraform import azurerm_postgresql_flexible_server_database.main "/subscriptions/865d39b1-0123-4c0a-97b1-b584ee4a1445/resourceGroups/consistly-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/consistlypg58260/databases/consistlydb"

Write-Host "All resources imported successfully!" 