##############################################################################
# Auth0 Configuration Module
#
# This module configures Auth0 resources including API (Resource Server),
# Application (Client), and Client Grants for OAuth 2.0 flows.
#
# Resources created:
# - Resource Server (API) for your backend
# - Client Application for accessing the API
# - Client Grant linking client to API with scopes
##############################################################################

# Create Auth0 API (Resource Server)
resource "auth0_resource_server" "this" {
  name        = var.server_apis.name        # API name displayed in Auth0 dashboard
  identifier  = var.server_apis.identifier  # Unique API identifier (audience)
  signing_alg = var.server_apis.signing_alg # Token signing algorithm (RS256, HS256)
}

# Create Auth0 Application (Client)
resource "auth0_client" "this" {nt)
resource "auth0_client" "this" {
  name                        = var.client_application.name
  description                 = var.client_application.description
  app_type                    = var.client_application.app_type                # spa, native, non_interactive, regular_web
  grant_types                 = var.client_application.grant_types             # authorization_code, client_credentials, etc.
  callbacks                   = var.client_application.callbacks               # Allowed callback URLs
  allowed_origins             = var.client_application.allowed_origins         # CORS allowed origins
  allowed_logout_urls         = var.client_application.allowed_logout_urls     # Post-logout redirect URLs
  web_origins                 = var.client_application.web_origins             # Allowed web origins
  require_proof_of_possession = var.client_application.require_proof_of_possession # DPoP requirement
  
  # Refresh token configuration
  dynamic "refresh_token" {
    for_each = var.client_application.refresh_token != null ? [1] : []
    content {
      rotation_type   = var.client_application.refresh_token.rotation_type   # rotating or non-rotating
      expiration_type = var.client_application.refresh_token.expiration_type # expiring or non-expiring
      leeway          = var.client_application.refresh_token.leeway          # Grace period in seconds
      token_lifetime  = var.client_application.refresh_token.token_lifetime  # Lifetime in seconds
    }
  }
}

# Grant client access to API with specific scopes
resource "auth0_client_grant" "this" {
  client_id = auth0_client.this.id                   # Client ID
  audience  = auth0_resource_server.this.identifier  # API identifier
  scopes    = var.client_grant.scopes                # Granted permissions/scopes
}
