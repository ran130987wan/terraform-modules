resource "helm_release" "nginx_gateway" {
  name             = var.nginx_gateway.name
  namespace        = var.nginx_gateway.namespace
  repository       = var.nginx_gateway.repository_name
  chart            = var.nginx_gateway.chart_name
  version          = try(var.nginx_gateway.helm_chart_version)
  create_namespace = try(var.nginx_gateway.create_namespace, true)
  timeout          = try(var.nginx_gateway.timeout, 600)

  set {
    name  = "nginx-gateway-fabric.enabled"
    value = "true"
  }
  set {
    name  = "service.create"
    value = "false"
  }
  set {
    name  = "nginxGateway.snippetsFilters.enable"
    value = "true"
  }
  set {
    name  = "nginxGateway.gwAPIExperimentalFeatures.enable"
    value = "true"
  }

  lifecycle { ignore_changes = [metadata] }
}
