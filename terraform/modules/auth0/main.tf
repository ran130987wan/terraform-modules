resource "auth0_resource_server" "this" {
  name        = var.server_apis.name
  identifier  = var.server_apis.identifier
  signing_alg = var.server_apis.signing_alg
}

resource "auth0_client" "this" {
  name                        = var.client_application.name
  description                 = var.client_application.description
  app_type                    = var.client_application.app_type
  grant_types                 = var.client_application.grant_types
  callbacks                   = var.client_application.callbacks
  allowed_origins             = var.client_application.allowed_origins
  allowed_logout_urls         = var.client_application.allowed_logout_urls
  web_origins                 = var.client_application.web_origins
  require_proof_of_possession = var.client_application.require_proof_of_possession
  dynamic "refresh_token" {
    for_each = var.client_application.refresh_token != null ? [1] : []
    content {
      rotation_type   = var.client_application.refresh_token.rotation_type
      expiration_type = var.client_application.refresh_token.expiration_type
      leeway          = var.client_application.refresh_token.leeway
      token_lifetime  = var.client_application.refresh_token.token_lifetime
    }
  }
}

resource "auth0_client_grant" "this" {
  client_id = auth0_client.this.id
  audience  = auth0_resource_server.this.identifier
  scopes    = var.client_grant.scopes
}
