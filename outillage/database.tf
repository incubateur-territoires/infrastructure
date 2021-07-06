resource "scaleway_rdb_instance" "outillage" {
  name           = "incubateur-outillage"
  node_type      = "db-dev-s"
  engine         = "PostgreSQL-12"
  is_ha_cluster  = false
  disable_backup = false
}

resource "scaleway_rdb_acl" "main" {
  instance_id = scaleway_rdb_instance.outillage.id
  acl_rules {
    ip          = "${scaleway_instance_server.outillage.public_ip}/32"
    description = "External IP of VM outillage"
  }
  acl_rules {
    ip          = "${scaleway_instance_server.outillage.private_ip}/32"
    description = "Internal IP of VM outillage"
  }
}