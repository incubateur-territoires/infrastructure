resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.4.0"
  wait       = true
  namespace  = kubernetes_namespace.cert-manager.metadata[0].name
  set {
    name  = "installCRDs"
    value = true
  }
}

resource "kubernetes_manifest" "cert-manager-clusterissuer-self-signing" {
  provider   = kubernetes-alpha
  depends_on = [helm_release.cert-manager]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "self-signing"
    }
    "spec" = {
      "selfSigned" = {}
    }
  }
}

resource "kubernetes_manifest" "cert-manager-clusterissuer-letsencrypt-staging" {
  provider   = kubernetes-alpha
  depends_on = [helm_release.cert-manager]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-staging"
    }
    "spec" = {
      "acme" = {
        "privateKeySecretRef" = {
          "name" = "letsencrypt-staging"
        }
        "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "haproxy"
              }
            }
            "selector" = {}
          },
        ]
      }
    }
  }

}

resource "kubernetes_manifest" "cert-manager-clusterissuer-letsencrypt-prod-monitored" {
  provider   = kubernetes-alpha
  depends_on = [helm_release.cert-manager]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prod-monitored"
    }
    "spec" = {
      "acme" = {
        "email" = var.acme_notification_email
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prod-monitored"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "haproxy"
              }
            }
            "selector" = {}
          },
        ]
      }
    }
  }

}

resource "kubernetes_manifest" "cert-manager-clusterissuer-letsencrypt-prod" {
  provider   = kubernetes-alpha
  depends_on = [helm_release.cert-manager]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prod"
    }
    "spec" = {
      "acme" = {
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prod"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "haproxy"
              }
            }
            "selector" = {}
          },
        ]
      }
    }
  }
}
