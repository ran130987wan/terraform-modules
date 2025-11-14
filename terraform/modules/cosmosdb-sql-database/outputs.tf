output "id" {
  description = "The ID of the Cosmos DB SQL database"
  value       = azurerm_cosmosdb_sql_database.this.id
}

output "name" {
  description = "The name of the Cosmos DB SQL database"
  value       = azurerm_cosmosdb_sql_database.this.name
}
