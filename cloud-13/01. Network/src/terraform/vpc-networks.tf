variable "settings_network" {
  description = "vpc name"
  type = object({
    vpc_name = string
    subnet_settings = list(object({
      name = string
      cidr_block = list(string)
    }))
  })
  default = {
    vpc_name            = "netology"
    subnet_settings = [ {
      name = "public",
      cidr_block = [ "192.168.10.0/24" ]
    },{
      name = "private",
      cidr_block = [ "192.168.20.0/24" ]
    } ]
  }
}

resource "yandex_vpc_network" "vpc_network_netology" {
  name = var.settings_network.vpc_name
}

resource "yandex_vpc_subnet" "vpc_subnet_public" {
  name           = var.settings_network.subnet_settings[0].name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc_network_netology.id
  v4_cidr_blocks = var.settings_network.subnet_settings[0].cidr_block
}

resource "yandex_vpc_subnet" "vpc_subnet_private" {
  name           = var.settings_network.subnet_settings[1].name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc_network_netology.id
  v4_cidr_blocks = var.settings_network.subnet_settings[1].cidr_block
  route_table_id = yandex_vpc_route_table.vpc_rb-private_route.id
}
