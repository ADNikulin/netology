variable "lemp_settings" {
  type                = list(object({
    name              = string
    cores             = number
    memory            = number
    core_fraction     = number
    platform_id       = string
  }))
  default = [{
      name            = "lamp-group"
      cores           = 2
      memory          = 2
      core_fraction   = 5
      platform_id     = "standard-v1"
    }]
}

variable "lemp_boot_disk" {
  type                = list(object({
    size              = number
    type              = string
    }))
  default = [ 
    {
      size            = 10
      type            = "network-hdd"
    }
  ]
}

resource "yandex_iam_service_account" "yisa-groupvm-sa" {
  name                = "groupvm-sa"
  description         = "Сервисный аккаунт для управления группой ВМ."
}

resource "yandex_resourcemanager_folder_iam_member" "yrfam-group-editor" {
  folder_id           = var.folder_id
  role                = "editor"
  member              = "serviceAccount:${yandex_iam_service_account.yisa-groupvm-sa.id}"
  depends_on          = [
    yandex_iam_service_account.yisa-groupvm-sa,
  ]
}

resource "yandex_compute_instance_group" "ycig-group-instances" {
  name                = var.lemp_settings[0].name
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.yisa-groupvm-sa.id}"
  deletion_protection = "false"
  depends_on          = [yandex_resourcemanager_folder_iam_member.yrfam-group-editor]

  instance_template {
    platform_id       = var.lemp_settings[0].platform_id

    resources {
      memory          = var.lemp_settings[0].memory
      cores           = var.lemp_settings[0].cores
      core_fraction   = var.lemp_settings[0].core_fraction
    }

    boot_disk {
      initialize_params {
        image_id        = data.yandex_compute_image.lemp.id
        type            = var.lemp_boot_disk[0].type
        size            = var.lemp_boot_disk[0].size
      }
    }

    network_interface {
      network_id          = "${yandex_vpc_network.vpc_network_netology.id}"
      subnet_ids          = ["${yandex_vpc_subnet.vpc_subnet_public.id}"]
      nat                 = true
    }

    scheduling_policy {
      preemptible         = true
    }

    metadata = {
      ssh-keys            = "ubuntu:${local.ssh-keys}"
      serial-port-enable  = "1"
      user-data           = <<EOF
#!/bin/bash
cd /var/www/html
echo '<html><head><title>Devops fuuuYeah</title></head> <body><h1>Devops fuuuYeah</h1><img src="http://${yandex_storage_bucket.alexander.bucket_domain_name}/devops.jpg"/></body></html>' > index.html
  EOF
    }
  }

  scale_policy {
    fixed_scale {
      size              = 3
    }
  }

  allocation_policy {
    zones               = [var.default_zone]
  }

  deploy_policy {
    max_unavailable     = 1
    max_expansion       = 0
  }

  health_check {
    interval            = 30
    timeout             = 10
    tcp_options {
      port              = 80
    }
  }

  load_balancer {
    target_group_name   = "lemp-group"
  }
}