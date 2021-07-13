terraform {
  required_providers {
    kubernetes = {
      version = "~> 2.3.2"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "~> 2.2.0"
      source  = "hashicorp/helm"
    }
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "~> 0.5.0"
    }
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
}
