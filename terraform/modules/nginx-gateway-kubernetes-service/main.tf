locals {
  ngf_service_annotations = (
    var.ngf_kubernetes_service.annotations != null
    ? var.ngf_kubernetes_service.annotations
    : (
      var.ngf_kubernetes_service.internal
      ? { "service.beta.kubernetes.io/azure-load-balancer-internal" = "true" }
      : {}
    )
  )
}

resource "kubernetes_service" "this" {
  count = var.ngf_kubernetes_service.enabled ? 1 : 0

  metadata {
    name        = var.ngf_kubernetes_service.name
    namespace   = var.ngf_kubernetes_service.namespace
    annotations = local.ngf_service_annotations
    labels      = var.ngf_kubernetes_service.labels
  }

  spec {
    type                    = var.ngf_kubernetes_service.type
    selector                = var.ngf_kubernetes_service.selector
    load_balancer_ip        = try(var.ngf_kubernetes_service.load_balancer_ip, null)
    external_traffic_policy = null
    session_affinity        = null

    dynamic "port" {
      for_each = var.ngf_kubernetes_service.ports
      content {
        name        = try(port.value.name, null)
        port        = port.value.port
        target_port = try(port.value.target_port, port.value.port)
        protocol    = try(port.value.protocol, "TCP")
      }
    }
  }
}
