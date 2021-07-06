resource "scaleway_instance_ip" "outillage" {

}

resource "scaleway_instance_volume" "outillage-n8n" {
  size_in_gb = 1
  type       = "b_ssd"
}

resource "scaleway_instance_server" "outillage" {
  type                  = "DEV1-M"
  image                 = "ubuntu_focal"
  enable_ipv6           = true
  ip_id                 = scaleway_instance_ip.outillage.id
  additional_volume_ids = [scaleway_instance_volume.outillage-n8n.id]

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.public_ip},' ansible/main.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  lifecycle {
    ignore_changes = [image]
  }
}