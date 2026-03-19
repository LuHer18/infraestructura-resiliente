output "namespace" {
  description = "Namespace creado"
  value       = kubernetes_namespace.mi_api_ns.metadata[0].name
}

output "deployment_name" {
  description = "Nombre del deployment"
  value       = kubernetes_deployment.mi_api.metadata[0].name
}

output "service_name" {
  description = "Nombre del service"
  value       = kubernetes_service.mi_api_service.metadata[0].name
}