output "acr_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "postgres_connection_string" {
  value = "postgresql://pgadmin:${random_password.postgres.result}@${azurerm_postgresql_flexible_server.main.fqdn}:5432/consistlydb"
}

output "backend_app_url" {
  value = azurerm_container_app.backend.latest_revision_fqdn
} 