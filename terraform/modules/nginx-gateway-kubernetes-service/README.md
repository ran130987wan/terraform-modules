# nginx-gateway-kubernetes-service

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_service.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ngf_kubernetes_service"></a> [ngf\_kubernetes\_service](#input\_ngf\_kubernetes\_service) | Configuration object for the NGINX Gateway Fabric Kubernetes Service (supports internal or public LoadBalancer, custom ports). | <pre>object({<br/>    enabled          = optional(bool, true)<br/>    name             = optional(string, "ngf-nginx")<br/>    namespace        = optional(string, "nginx-gateway")<br/>    type             = optional(string, "LoadBalancer")<br/>    internal         = optional(bool, true) # when true adds internal LB annotation if none provided<br/>    load_balancer_ip = optional(string)     # optional static public IP (or internal) pre-provisioned<br/>    annotations      = optional(map(string))<br/>    labels           = optional(map(string), { "app.kubernetes.io/instance" = "nginx-gateway", "app.kubernetes.io/name" = "nginx-gateway-fabric" })<br/>    selector         = optional(map(string), { "app.kubernetes.io/instance" = "nginx-gateway", "app.kubernetes.io/name" = "nginx-gateway-fabric" })<br/>    ports = optional(list(object({<br/>      name        = optional(string)<br/>      port        = number<br/>      target_port = optional(number)<br/>      protocol    = optional(string, "TCP")<br/>      })), [<br/>      {<br/>        name        = "http"<br/>        port        = 80<br/>        target_port = 80<br/>        protocol    = "TCP"<br/>      },<br/>      {<br/>        name        = "https"<br/>        port        = 443<br/>        target_port = 443<br/>        protocol    = "TCP"<br/>      }<br/>    ])<br/>  })</pre> | <pre>{<br/>  "enabled": true,<br/>  "internal": true<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ip"></a> [cluster\_ip](#output\_cluster\_ip) | ClusterIP of the service (if allocated) |
| <a name="output_load_balancer_ips"></a> [load\_balancer\_ips](#output\_load\_balancer\_ips) | List of Load Balancer ingress IPs for the service (if provisioned). |
| <a name="output_name"></a> [name](#output\_name) | Service name |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Service namespace |
<!-- END_TF_DOCS -->
