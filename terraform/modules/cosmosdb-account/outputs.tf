output "id" {
  description = "The id of the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.id
}

output "name" {
  description = "The name of the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.name
}

output "resource_group_name" {
  description = "The resource group name containing the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.resource_group_name
}

output "cosmosdb_account_endpoint" {
  description = "The endpoint URI of the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_account_primary_key" {
  description = "The primary key for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_key
  sensitive   = true
}

output "cosmosdb_account_secondary_key" {
  description = "The secondary key for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_key
  sensitive   = true
}

output "cosmosdb_account_primary_readonly_key" {
  description = "The primary read-only key for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_readonly_key
  sensitive   = true
}

output "cosmosdb_account_secondary_readonly_key" {
  description = "The secondary read-only key for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_readonly_key
  sensitive   = true
}

output "cosmosdb_account_primary_sql_connection_string" {
  description = "The primary SQL connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_sql_connection_string
  sensitive   = true
}

output "cosmosdb_account_secondary_sql_connection_string" {
  description = "The secondary SQL connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_sql_connection_string
  sensitive   = true
}

output "cosmosdb_account_primary_readonly_sql_connection_string" {
  description = "The primary read-only SQL connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_readonly_sql_connection_string
  sensitive   = true
}

output "cosmosdb_account_secondary_readonly_sql_connection_string" {
  description = "The secondary read-only SQL connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_readonly_sql_connection_string
  sensitive   = true
}

output "cosmosdb_account_primary_mongodb_connection_string" {
  description = "The primary MongoDB connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_mongodb_connection_string
  sensitive   = true
}

output "cosmosdb_account_secondary_mongodb_connection_string" {
  description = "The secondary MongoDB connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_mongodb_connection_string
  sensitive   = true
}

output "cosmosdb_account_primary_readonly_mongodb_connection_string" {
  description = "The primary read-only MongoDB connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.primary_readonly_mongodb_connection_string
  sensitive   = true
}

output "cosmosdb_account_secondary_readonly_mongodb_connection_string" {
  description = "The secondary read-only MongoDB connection string for the Cosmos DB account."
  value       = azurerm_cosmosdb_account.this.secondary_readonly_mongodb_connection_string
  sensitive   = true
}
