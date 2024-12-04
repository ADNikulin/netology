variable "k8s_master_init" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "master"
      cores         = 2
      memory        = 2
      core_fraction = 5
      count_vms = 3
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_master" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
  }]
}


resource "yandex_compute_instance" "master" {
  name        = "${var.k8s_master_init[0].vm_name}-${count.index+1}"
  platform_id = var.k8s_master_init[0].platform_id

  count = var.k8s_master_init[0].count_vms

  resources {
    cores         = var.k8s_master_init[0].cores
    memory        = var.k8s_master_init[0].memory
    core_fraction = var.k8s_master_init[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-master.image_id
      type     = var.boot_disk_master[0].type
      size     = var.boot_disk_master[0].size
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology.id
    nat       = true
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }
  scheduling_policy {
    preemptible = true
  }
}