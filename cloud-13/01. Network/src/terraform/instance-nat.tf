variable "yandex_compute_instance_nat" {
  type = object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    hostname = string
    platform_id = string
  })

  default = {
      vm_name       = "nat_instance"
      cores         = 2
      memory        = 2
      core_fraction = 5
      hostname      = "nat"
      platform_id   = "standard-v1"
    }
}

variable "boot_disk_nat" {
  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "network-hdd"
  }
}

resource "yandex_compute_instance" "nat_instance" {
  name        = var.yandex_compute_instance_nat.vm_name
  platform_id = var.yandex_compute_instance_nat.platform_id
  hostname = var.yandex_compute_instance_nat.hostname

  resources {
    cores         = var.yandex_compute_instance_nat.cores
    memory        = var.yandex_compute_instance_nat.memory
    core_fraction = var.yandex_compute_instance_nat.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-instance-ubuntu.id
      type     = var.boot_disk_nat.type
      size     = var.boot_disk_nat.size
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.vpc_subnet_public.id
    nat        = true
    ip_address = "192.168.10.254"
  }
  scheduling_policy {
    preemptible = true
  }
}