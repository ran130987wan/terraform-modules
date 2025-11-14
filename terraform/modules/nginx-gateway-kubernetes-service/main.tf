##############################################################################
# NGINX Gateway Kubernetes Service Module
#
# This module creates a Kubernetes Service to expose the NGINX Gateway
# Fabric deployment. Supports both internal and external load balancers.
#
# Features:
# - Internal or external Azure Load Balancer
# - Custom annotations for Azure LB configuration
# - Multiple port mappings
# - Static IP assignment
##############################################################################

locals {
  # Set Azure internal load balancer annotation if internal mode is enabled
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
    annotations = local.ngf_service_annotations # Azure LB annotations
    labels      = var.ngf_kubernetes_service.labels
  }

  spec {
    type                    = var.ngf_kubernetes_service.type               # LoadBalancer, ClusterIP, NodePort
    selector                = var.ngf_kubernetes_service.selector           # Pod selector labels
    load_balancer_ip        = try(var.ngf_kubernetes_service.load_balancer_ip, null) # Static IP (optional)
    external_traffic_policy = null                                          # Cluster or Local
    session_affinity        = null                                          # ClientIP or None

    # Define service ports
    dynamic "port" {
      for_each = var.ngf_kubernetes_service.ports
      content {
        name        = try(port.value.name, null)                           # Port name
        port        = port.value.port                                       # Service port
        target_port = try(port.value.target_port, port.value.port)         # Container port
        protocol    = try(port.value.protocol, "TCP")                      # TCP or UDP
      }
    }
  }
}
