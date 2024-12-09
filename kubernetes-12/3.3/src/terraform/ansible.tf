resource "local_file" "hosts_cfg_kubespray" {
  content  = templatefile("${path.module}/templates/hosts.tftpl", {
    workers = yandex_compute_instance.worker
    masters = yandex_compute_instance.master
  })
  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}

resource "local_file" "hosts_cfg_ha" {
  content  = templatefile("${path.module}/templates/ha.tftpl", {
    workers = yandex_compute_instance.worker
    masters = yandex_compute_instance.master
  })
  filename = "../HA/hosts.yaml"
}