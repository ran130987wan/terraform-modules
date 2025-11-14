# nat-gateway

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.16 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.16 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.nginx_gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nginx_gateway"></a> [nginx\_gateway](#input\_nginx\_gateway) | Configuration object for NGINX Gateway Fabric Helm deployment. | <pre>object({<br/>    name               = string # release name<br/>    chart_name         = optional(string, "nginx-gateway-fabric")<br/>    repository_name    = optional(string, "oci://ghcr.io/nginx/charts")<br/>    namespace          = string                    # target namespace<br/>    create_namespace   = optional(bool, true)      # create namespace if missing<br/>    helm_chart_version = optional(string, "1.6.2") # chart version<br/>    timeout            = optional(number, 600)     # seconds helm install timeout<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ngf_install_status"></a> [ngf\_install\_status](#output\_ngf\_install\_status) | n/a |
<!-- END_TF_DOCS -->
