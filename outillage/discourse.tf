resource "scaleway_rdb_database" "discourse" {
  instance_id = scaleway_rdb_instance.outillage.id
  name        = "discourse"
}

resource "random_password" "discourse_db_password" {
  length      = 16
  min_numeric = 1
  special     = true
}

resource "scaleway_rdb_user" "discourse_user" {
  instance_id = scaleway_rdb_instance.outillage.id
  name        = "discourse"
  password    = random_password.discourse_db_password.result
  is_admin    = false
}

resource "scaleway_object_bucket" "discourse" {
  name = "incubateur-discourse"
  acl  = "public-read"
}

resource "null_resource" "discourse_inventory" {
  provisioner "local-exec" {
    command     = <<EOT
    cat << EOF > ansible_discourse_inventory.ini
[all:vars]
discourse_db_password=${random_password.discourse_db_password.result}
discourse_db_user=${scaleway_rdb_user.discourse_user.name}
discourse_db_host=${scaleway_rdb_instance.outillage.endpoint_ip}
discourse_db_port='${scaleway_rdb_instance.outillage.endpoint_port}'
discourse_db_database=${scaleway_rdb_database.discourse.name}
discourse_s3_access_key_id=${var.s3_access_key_id}
discourse_s3_secret_access_key=${var.s3_secret_access_key}
discourse_s3_cdn_url=${scaleway_object_bucket.discourse.endpoint}
discourse_s3_bucket=${scaleway_object_bucket.discourse.name}
discourse_smtp_address=${var.smtp_address}
discourse_smtp_password=${var.smtp_password}
discourse_smtp_port=${var.smtp_port}
discourse_smtp_user_name=${var.smtp_user}
[outillage]
${scaleway_instance_ip.outillage.address}
  EOT
    interpreter = ["bash", "-c"]
  }
}
