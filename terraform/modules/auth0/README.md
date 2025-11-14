# auth0

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_auth0"></a> [auth0](#requirement\_auth0) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_auth0"></a> [auth0](#provider\_auth0) | >= 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [auth0_client.this](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client) | resource |
| [auth0_client_grant.this](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client_grant) | resource |
| [auth0_resource_server.this](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/resource_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_application"></a> [client\_application](#input\_client\_application) | set up applications that use Auth0 for authentication | <pre>object({<br/>    name                        = string<br/>    description                 = string<br/>    app_type                    = string<br/>    grant_types                 = optional(list(string))<br/>    callbacks                   = optional(list(string))<br/>    allowed_origins             = optional(list(string))<br/>    allowed_logout_urls         = optional(list(string))<br/>    web_origins                 = optional(list(string))<br/>    require_proof_of_possession = optional(bool)<br/>    refresh_token = optional(object({<br/>      rotation_type   = string<br/>      expiration_type = string<br/>      leeway          = optional(number, 0)<br/>      token_lifetime  = optional(number, 0)<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_client_grant"></a> [client\_grant](#input\_client\_grant) | Auth0 uses various grant types, or methods by which you grant limited access to your resources to another entity without exposing credentials | <pre>object({<br/>    scopes = optional(list(string), [])<br/>  })</pre> | n/a | yes |
| <a name="input_server_apis"></a> [server\_apis](#input\_server\_apis) | API configuration that can be consumed from the authorized applications | <pre>object({<br/>    name        = string<br/>    identifier  = string<br/>    signing_alg = optional(string, "RS256")<br/>  })</pre> | <pre>{<br/>  "identifier": "",<br/>  "name": "",<br/>  "signing_alg": "RS256"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_client_id"></a> [application\_client\_id](#output\_application\_client\_id) | n/a |
| <a name="output_created_apis"></a> [created\_apis](#output\_created\_apis) | The identifier of the created API |
<!-- END_TF_DOCS -->
