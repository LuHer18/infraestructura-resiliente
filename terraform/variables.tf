variable "namespace_name" {
  description = "Nombre del namespace"
  type        = string
  default     = "mi-api-ns"
}

variable "kubeconfig_path" {
  description = "Ruta al kubeconfig local"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Contexto de Kubernetes a usar"
  type        = string
  default     = "minikube"
}

variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
  default     = "mi-api"
}

variable "image" {
  description = "Imagen del contenedor"
  type        = string
  default     = "luher/mi-api:latest"
}

variable "replicas" {
  description = "Cantidad de réplicas"
  type        = number
  default     = 3
}

variable "container_port" {
  description = "Puerto del contenedor"
  type        = number
  default     = 3000
}

variable "service_port" {
  description = "Puerto del servicio"
  type        = number
  default     = 8080
}

variable "service_type" {
  description = "Tipo de servicio Kubernetes"
  type        = string
  default     = "NodePort"
}

variable "cpu_request" {
  description = "CPU request"
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Memoria request"
  type        = string
  default     = "128Mi"
}

variable "cpu_limit" {
  description = "CPU limit"
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memoria limit"
  type        = string
  default     = "256Mi"
}
