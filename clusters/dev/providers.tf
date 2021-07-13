provider "kubernetes" {
  host                   = scaleway_k8s_cluster.development.kubeconfig[0].host
  token                  = scaleway_k8s_cluster.development.kubeconfig[0].token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.development.kubeconfig[0].cluster_ca_certificate)
}

provider "kubernetes-alpha" {
  host                   = scaleway_k8s_cluster.development.kubeconfig[0].host
  token                  = scaleway_k8s_cluster.development.kubeconfig[0].token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.development.kubeconfig[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = scaleway_k8s_cluster.development.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.development.kubeconfig[0].token
    cluster_ca_certificate = base64decode(scaleway_k8s_cluster.development.kubeconfig[0].cluster_ca_certificate)
  }
}

provider "scaleway" {
  region     = "fr-par"
  zone       = "fr-par-1"
  project_id = var.scaleway_project_id
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
}
