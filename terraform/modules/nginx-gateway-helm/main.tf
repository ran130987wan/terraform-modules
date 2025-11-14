##############################################################################
# NGINX Gateway Fabric Helm Chart Module
#
# This module deploys NGINX Gateway Fabric via Helm chart in a Kubernetes
# cluster. NGINX Gateway Fabric is an implementation of the Kubernetes
# Gateway API using NGINX as the data plane.
#
# Features:
# - Kubernetes Gateway API support
# - Advanced routing capabilities
# - Traffic splitting and header manipulation
# - Experimental features support
##############################################################################

resource "helm_release" "nginx_gateway" {
  name             = var.nginx_gateway.name
  namespace        = var.nginx_gateway.namespace                          # K8s namespace
  repository       = var.nginx_gateway.repository_name                    # Helm repository URL
  chart            = var.nginx_gateway.chart_name                         # Chart name
  version          = try(var.nginx_gateway.helm_chart_version)            # Chart version
  create_namespace = try(var.nginx_gateway.create_namespace, true)        # Auto-create namespace
  timeout          = try(var.nginx_gateway.timeout, 600)                  # Install timeout (seconds)

  # Enable NGINX Gateway Fabric component
  set {
    name  = "nginx-gateway-fabric.enabled"
    value = "true"
  }
  
  # Disable default service creation (managed separately)
  set {
    name  = "service.create"
    value = "false"
  }
  
  # Enable snippets filters for custom NGINX config
  set {
    name  = "nginxGateway.snippetsFilters.enable"
    value = "true"
  }
  
  # Enable experimental Gateway API features
  set {
    name  = "nginxGateway.gwAPIExperimentalFeatures.enable"
    value = "true"
  }

  lifecycle { ignore_changes = [metadata] }
}
