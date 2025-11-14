output "name" {
  description = "Cosmos DB SQL container name."
  value       = azurerm_cosmosdb_sql_container.this.name
}

output "id" {
  description = "Cosmos DB SQL container resource ID."
  value       = azurerm_cosmosdb_sql_container.this.id
}

