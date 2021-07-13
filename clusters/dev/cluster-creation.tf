resource "scaleway_k8s_cluster" "development" {
  name        = "Incubateur-dev"
  description = "Managed by terraform"
  version     = "1.21.1"
  cni         = "calico"
  tags        = ["development"]
  project_id  = "c9c64ec8-258e-4f79-848e-8c297e2ef7a7"
}

resource "scaleway_k8s_pool" "default" {
  cluster_id          = scaleway_k8s_cluster.development.id
  name                = "default"
  node_type           = "DEV1-M"
  size                = 1
  autohealing         = true
  wait_for_pool_ready = true
  autoscaling         = true
  max_size            = 5
}