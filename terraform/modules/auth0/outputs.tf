output "application_client_id" {
  value     = auth0_client.this.client_id
  sensitive = true
}

output "created_apis" {
  value = {
    identifier = auth0_resource_server.this.identifier
  }
  description = "The identifier of the created API"
}
