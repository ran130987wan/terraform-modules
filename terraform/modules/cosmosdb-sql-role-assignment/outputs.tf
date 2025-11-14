output "id" {
  description = "The ID of the Cosmos DB SQL role assignment"
  value       = azurerm_cosmosdb_sql_role_assignment.this.id
}

output "name" {
  description = "The name of the Cosmos DB SQL role assignment"
  value       = azurerm_cosmosdb_sql_role_assignment.this.name
}
