variable "yandex_compute_instance_private" {
  type = object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    hostname = string
    platform_id = string
  })

  default = {
      vm_name = "private_instance"
      cores         = 2
      memory        = 2
      core_fraction = 5
      hostname = "private"
      platform_id = "standard-v1"
    }
}

variable "boot_disk_private" {
  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "network-hdd"
  }
}

resource "yandex_compute_instance" "private" {
  name        = var.yandex_compute_instance_private.vm_name
  platform_id = var.yandex_compute_instance_private.platform_id
  hostname = var.yandex_compute_instance_private.hostname

  resources {
    cores         = var.yandex_compute_instance_private.cores
    memory        = var.yandex_compute_instance_private.memory
    core_fraction = var.yandex_compute_instance_private.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2404_image.id
      type     = var.boot_disk_private.type
      size     = var.boot_disk_private.size
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.vpc_subnet_private.id
    nat        = false
  }
  scheduling_policy {
    preemptible = true
  }
}