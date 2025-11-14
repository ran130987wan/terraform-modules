variable "nginx_gateway" {
  description = "Configuration object for NGINX Gateway Fabric Helm deployment."
  type = object({
    name               = string # release name
    chart_name         = optional(string, "nginx-gateway-fabric")
    repository_name    = optional(string, "oci://ghcr.io/nginx/charts")
    namespace          = string                    # target namespace
    create_namespace   = optional(bool, true)      # create namespace if missing
    helm_chart_version = optional(string, "1.6.2") # chart version
    timeout            = optional(number, 600)     # seconds helm install timeout
  })
}
