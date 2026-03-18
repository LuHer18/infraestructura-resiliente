terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "mi_api_ns" {
  metadata {
    name = "mi-api-ns"
  }
}

resource "kubernetes_deployment" "mi_api" {
  metadata {
    name      = "mi-api"
    namespace = kubernetes_namespace.mi_api_ns.metadata[0].name
    labels = {
      app = "mi-api"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "mi-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "mi-api"
        }
      }

      spec {
        container {
          name  = "mi-api"
          image = "luher/mi-api:latest"

          port {
            container_port = 3000
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mi_api_service" {
  metadata {
    name      = "mi-api-service"
    namespace = kubernetes_namespace.mi_api_ns.metadata[0].name
  }

  spec {
    selector = {
      app = "mi-api"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}