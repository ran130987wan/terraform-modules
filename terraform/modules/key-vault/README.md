# key-vault

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vault"></a> [vault](#input\_vault) | Configuration object for the Azure Key Vault. | <pre>object({<br/>    name                            = string<br/>    location                        = string<br/>    resource_group_name             = string<br/>    sku_name                        = optional(string, "standard") # standard | premium<br/>    tenant_id                       = string<br/>    soft_delete_retention_days      = optional(number, 7)<br/>    purge_protection_enabled        = optional(bool, false)<br/>    public_network_access_enabled   = optional(bool, true)<br/>    enabled_for_disk_encryption     = optional(bool, false)<br/>    enabled_for_deployment          = optional(bool, false)<br/>    enabled_for_template_deployment = optional(bool, false)<br/>    rbac_authorization_enabled      = optional(bool, true)<br/>    access_policies = optional(list(object({<br/>      tenant_id               = string<br/>      object_id               = string<br/>      key_permissions         = optional(list(string), [])<br/>      secret_permissions      = optional(list(string), [])<br/>      certificate_permissions = optional(list(string), [])<br/>      storage_permissions     = optional(list(string), [])<br/>    })), [])<br/>    network_acls = optional(object({<br/>      bypass                     = string<br/>      default_action             = string<br/>      ip_rules                   = optional(list(string), [])<br/>      virtual_network_subnet_ids = optional(list(string), [])<br/>    }))<br/>    tags = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "access_policies": [],<br/>  "enabled_for_deployment": false,<br/>  "enabled_for_disk_encryption": false,<br/>  "enabled_for_template_deployment": false,<br/>  "location": "",<br/>  "name": "",<br/>  "network_acls": null,<br/>  "public_network_access_enabled": false,<br/>  "purge_protection_enabled": true,<br/>  "resource_group_name": "",<br/>  "sku_name": "standard",<br/>  "soft_delete_retention_days": 7,<br/>  "tags": {},<br/>  "tenant_id": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault. |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | The URI of the Key Vault. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name of the Key Vault. |
<!-- END_TF_DOCS -->
