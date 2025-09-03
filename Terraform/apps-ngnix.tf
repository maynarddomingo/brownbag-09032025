 
# Deployment
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-website"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-website"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-website"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "nginx_svc" {
  metadata {
    name = "nginx-website-svc"
  }

  spec {
    selector = {
      app = kubernetes_deployment.nginx.metadata[0].name
      # Or use: "app" = "nginx-website"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
