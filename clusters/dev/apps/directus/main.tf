resource "helm_release" "directus" {
  name  = "directus"
  chart = "https://github.com/directus-community/helm-chart/archive/refs/heads/master.tar.gz"
}
