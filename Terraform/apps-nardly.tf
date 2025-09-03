# Deployment
resource "kubernetes_deployment" "nardly" {
  metadata {
    name = "nardly-website"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nardly-website"
      }
    }

    template {
      metadata {
        labels = {
          app = "nardly-website"
        }
      }

      spec {
        container {
          name  = "nardly"
          image = "maynarddomingo/brownbag-08042025:latest"

          port {
            container_port = 8090
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "nardly_svc" {
  metadata {
    name = "nardly-website-svc"
  }

  spec {
    selector = {
      app = "nardly-website"
    }

    port {
      port        = 8090
      target_port = 8090
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
