resource "kubernetes_namespace" "mi_api_ns" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "mi_api" {
  depends_on = [kubernetes_namespace.mi_api_ns]
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.mi_api_ns.metadata[0].name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = var.image

          port {
            container_port = var.container_port
          }

          resources {
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mi_api_service" {
  depends_on = [kubernetes_namespace.mi_api_ns]
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace.mi_api_ns.metadata[0].name
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = var.service_type
  }
}