output "name" {
  description = "Service name"
  value       = try(kubernetes_service.this[0].metadata[0].name, null)
}

output "namespace" {
  description = "Service namespace"
  value       = try(kubernetes_service.this[0].metadata[0].namespace, null)
}

output "cluster_ip" {
  description = "ClusterIP of the service (if allocated)"
  value       = try(kubernetes_service.this[0].spec[0].cluster_ip, null)
}

output "load_balancer_ips" {
  description = "List of Load Balancer ingress IPs for the service (if provisioned)."
  value = (
    length(kubernetes_service.this) == 0 || length(try(kubernetes_service.this[0].status, [])) == 0
    ? []
    : [for ing in try(kubernetes_service.this[0].status[0].load_balancer[0].ingress, []) : ing.ip]
  )
}
