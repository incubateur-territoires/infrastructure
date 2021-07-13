resource "kubernetes_namespace" "gateway" {
  metadata {
    name = "gateway"
  }
}

resource "scaleway_lb_ip" "haproxy-ip" {}

resource "helm_release" "haproxy" {
  name       = "haproxy"
  repository = "https://haproxytech.github.io/helm-charts/"
  chart      = "kubernetes-ingress"
  version    = "1.16.0"
  namespace  = kubernetes_namespace.gateway.metadata[0].name

  set {
    name  = "controller.image.tag"
    value = "1.6.4"
  }

  set {
    name  = "controller.service.enablePorts.stat"
    value = "false"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = scaleway_lb_ip.haproxy-ip.ip_address
  }

  set {
    name  = "controller.ingressClass"
    value = "haproxy"
  }

  set {
    name  = "controller.replicaCount"
    value = "null"
  }

  set {
    name  = "defaultBackend.replicaCount"
    value = "null"
  }

  set {
    name  = "controller.extraArgs"
    value = "{\"--ignore-ingress-without-class\"}"
  }
}
