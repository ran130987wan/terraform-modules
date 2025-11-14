variable "ngf_kubernetes_service" {
  description = "Configuration object for the NGINX Gateway Fabric Kubernetes Service (supports internal or public LoadBalancer, custom ports)."
  type = object({
    enabled          = optional(bool, true)
    name             = optional(string, "ngf-nginx")
    namespace        = optional(string, "nginx-gateway")
    type             = optional(string, "LoadBalancer")
    internal         = optional(bool, true) # when true adds internal LB annotation if none provided
    load_balancer_ip = optional(string)     # optional static public IP (or internal) pre-provisioned
    annotations      = optional(map(string))
    labels           = optional(map(string), { "app.kubernetes.io/instance" = "nginx-gateway", "app.kubernetes.io/name" = "nginx-gateway-fabric" })
    selector         = optional(map(string), { "app.kubernetes.io/instance" = "nginx-gateway", "app.kubernetes.io/name" = "nginx-gateway-fabric" })
    ports = optional(list(object({
      name        = optional(string)
      port        = number
      target_port = optional(number)
      protocol    = optional(string, "TCP")
      })), [
      {
        name        = "http"
        port        = 80
        target_port = 80
        protocol    = "TCP"
      },
      {
        name        = "https"
        port        = 443
        target_port = 443
        protocol    = "TCP"
      }
    ])
  })
  default = {
    enabled  = true
    internal = true
  }
}
