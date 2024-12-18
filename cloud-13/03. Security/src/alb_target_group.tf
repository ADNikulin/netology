resource "yandex_alb_target_group" "alb-group" {
  name            = "group-instances"

  target {
    subnet_id     = yandex_vpc_subnet.vpc_subnet_public.id
    ip_address    = yandex_compute_instance_group.ycig-group-instances.instances.0.network_interface.0.ip_address
  }

  target {
    subnet_id     = yandex_vpc_subnet.vpc_subnet_public.id
    ip_address    = yandex_compute_instance_group.ycig-group-instances.instances.1.network_interface.0.ip_address
  }

  target {
    subnet_id     = yandex_vpc_subnet.vpc_subnet_public.id
    ip_address    = yandex_compute_instance_group.ycig-group-instances.instances.2.network_interface.0.ip_address
  }

  depends_on      = [
    yandex_compute_instance_group.ycig-group-instances
  ]
}