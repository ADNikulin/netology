variable "worker_count" {
  type    = number
  default = 4
}

variable "worker_resources" {
  type = object({
    cpu         = number
    ram         = number
    disk        = number
    platform_id = string
  })
  default = {
    cpu         = 2
    ram         = 2
    disk        = 10
    platform_id = "standard-v1"
  }
}

resource "yandex_compute_instance" "worker" {
  depends_on = [yandex_compute_instance.master]
  count      = var.worker_count

  name          = "worker-${count.index + 1}"
  platform_id   = var.worker_resources.platform_id

  resources {
    cores         = var.worker_resources.cpu
    memory        = var.worker_resources.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-worker.image_id
      size     = var.worker_resources.disk
    }
  }

  metadata = {
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.netology.id
    nat                = true
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = true
  }
}