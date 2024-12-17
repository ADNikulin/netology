data "yandex_compute_image" "ubuntu_2404_image" {
  family            = "ubuntu-2404-lts-oslogin"
}

data "yandex_compute_image" "nat-instance-ubuntu" {
  family            = "nat-instance-ubuntu"
}

data "yandex_compute_image" "lemp" {
  family            = "lemp"
}

locals {
  ssh-keys          = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys  = file("~/.ssh/id_ed25519")
}