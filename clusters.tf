module "cluster-dev" {
  source                  = "./clusters/dev"
  acme_notification_email = var.acme_notification_email
  scaleway_project_id     = var.scaleway_cluster_dev_project_id
  scaleway_access_key     = var.scaleway_cluster_dev_access_key
  scaleway_secret_key     = var.scaleway_cluster_dev_secret_key
}
