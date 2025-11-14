##############################################################################
# Azure Federated Identity Credential Module
#
# This module creates a federated identity credential for workload identity
# federation, enabling external identity providers (like Kubernetes, GitHub)
# to authenticate to Azure without using secrets.
#
# Use cases:
# - AKS workload identity for pod authentication
# - GitHub Actions authentication to Azure
# - External OIDC provider authentication
##############################################################################

resource "azurerm_federated_identity_credential" "federated_identity" {
  name                = var.federated_identity_credential.name
  resource_group_name = var.federated_identity_credential.resource_group_name
  parent_id           = var.federated_identity_credential.parent_id  # User-assigned identity resource ID
  audience            = var.federated_identity_credential.audiences  # Intended audience (typically api://AzureADTokenExchange)
  issuer              = var.federated_identity_credential.issuer     # OIDC issuer URL (e.g., AKS OIDC issuer)
  subject             = var.federated_identity_credential.subject    # Subject identifier (e.g., system:serviceaccount:namespace:sa-name)
}
