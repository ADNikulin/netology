resource "yandex_alb_load_balancer" "application-balancer" {
  name          = "app-balancer"
  network_id    = yandex_vpc_network.vpc_network_netology.id

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = yandex_vpc_subnet.vpc_subnet_public.id
    }
  }

  listener {
    name        = "listener"

    endpoint {
      address {
        external_ipv4_address {
        }
      }

      ports     = [ 80 ]
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }

  depends_on    = [
    yandex_alb_http_router.http-router
  ] 
}