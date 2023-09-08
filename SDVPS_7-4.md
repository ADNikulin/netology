# 7.4. Виртуализация — Никулин Александр
# Домашнее задание к занятию «Подъём инфраструктуры в Yandex Cloud»

 ---
### Задание 1 

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

От заказчика получено задание: при помощи Terraform и Ansible собрать виртуальную инфраструктуру и развернуть на ней веб-ресурс. 

В инфраструктуре нужна одна машина с ПО ОС Linux, двумя ядрами и двумя гигабайтами оперативной памяти. 

Требуется установить nginx, залить при помощи Ansible конфигурационные файлы nginx и веб-ресурса. 

Секретный токен от yandex cloud должен вводится в консоли при каждом запуске terraform.

Для выполнения этого задания нужно сгенирировать SSH-ключ командой ssh-kengen. Добавить в конфигурацию Terraform ключ в поле:

```
 metadata = {
    user-data = "${file("./meta.txt")}"
  }
``` 

В файле meta прописать: 
 
```
 users:
  - name: user
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ssh-rsa  xxx
```
Где xxx — это ключ из файла /home/"name_ user"/.ssh/id_rsa.pub. Примерная конфигурация Terraform:

```
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "yandex_cloud_token" {
  type = string
  description = "Введите секретный токен от yandex_cloud"
}

provider "yandex" {
  token     = var.yandex_cloud_token #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  cloud_id  = "xxx"
  folder_id = "xxx"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87kbts7j40q5b9rpjr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
```

В конфигурации Ansible указать:

* внешний IP-адрес машины, полученный из output external_ ip_ address_ vm_1, в файле hosts;
* доступ в файле plabook *yml поля hosts.

```
- hosts: 138.68.85.196
  remote_user: user
  tasks:
    - service:
        name: nginx
        state: started
      become: yes
      become_method: sudo
```

Провести тестирование. 

### Решение 1
Подготовил следующую струткуру проекта: (Проект распологается в директории ```~/Projects/terraform/```) \
```
.
└── test/
    ├── live/
    │   └── stage/
    │       ├── main.tf
    │       ├── outputs.tf
    │       ├── variables.tf
    │       └── terraforms.tfvars
    └── modules/
        ├── networks/
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── servers/
            ├── main.tf
            ├── outputs.tf
            └── variables.tf
```
> Где Live - это пространство (стенд, контур, среда). \
> В нем есть папка stage, которая имитирует вспроизводимую среду. \
> Соответсвено modules это список модулей (объектов которые будем создовать), которые можно переиспользовать. \
> В них есть подпапки которые имитируют создаваемые объекты.

![image](https://github.com/ADNikulin/netology/assets/44374132/a4856b18-6899-4115-9fca-5700fa8ee484) \

Содержание файлов network модулей: \
network модуль отвечает за создание виртуальной сети \
```/test/modules/network/variables.tf```
```
# Список переменных для модуля, которые необходимо передать для корректной его работы
variable "zone" {
  description = "network-zone, ru-central1-a or ru-central1-b or ru-central1-c"
  default     = "ru-central1-b"
  type        = string
}

variable "network-name" {
  description = "Network name"
  type        = string
}

variable "subnet-name" {
  description = "Subnet name"
  type        = string
}

variable "v4_cidr_blocks" {
  description = "pool of ipv4 addresses, e.g "
  type        = string
}

variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор зоны"
  type        = string
}

variable "service_account_key_file" {
  description = "Укажите путь до файла с ключом к доступу в облако для сервисного аккаунта"
  type        = string
}
```

```/test/modules/network/outputs.tf``` 
``` 
# Список выходных значений модуля
output "network_name" {
    value = yandex_vpc_network.network-main.name
}

output "network_id" {
    value = yandex_vpc_network.network-main.id
}

output "subnet_name" {
    value = yandex_vpc_subnet.subnet-a.name
}

output "subnet_id" {
    value = yandex_vpc_subnet.subnet-a.id
}
```

```/test/modules/network/main.tf```
``` 
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# Сеть
resource "yandex_vpc_network" "network-main" {
  name = var.network-name
}

# Подсеть
resource "yandex_vpc_subnet" "subnet-a" {
  v4_cidr_blocks = [var.v4_cidr_blocks]
  name           = var.subnet-name
  zone           = var.zone
  network_id     = yandex_vpc_network.network-main.id
}
```

Далее идет модуль servers. Сущность для создания серверов. В теории данную категорию можно расширить с заранее подготовленными исходными данными, т.е. ОС, ядра и т.п. и добавить больше категорий. Но думаю что для тестов и дз нам это не важно.

```/test/modules/servers/variables.tf```
```
# Список переменных для модуля, которые необходимо передать для корректной его работы
variable "zone" {
  description = "network-zone, ru-central1-a or ru-central1-b or ru-central1-c"
  default     = "ru-central1-b"
  type        = string
}

variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор зоны"
  type        = string
}

variable "service_account_key_file" {
  description = "Укажите путь до файла с ключом к доступу в облако для сервисного аккаунта"
  type        = string
}

variable "server-app-name" {
  description = "Name VM in controll web"
  type        = string
}

variable "server-host-name" {
  description = "VM machine name"
  type        = string
}

variable "core_fraction" {
  description = "Доля процессорного времени"
  type        = number
  default     = 20
}

variable "servers_subnet_id" {
  description = "Subnet ID"
  type        = string
}
```

```/test/modules/servers/outputs.tf``` 
``` 
# Список выходных значений модуля
output "internal_ip_address_server" {
  value = yandex_compute_instance.server.network_interface.0.ip_address
}

output "external_ip_address_server" {
  value = yandex_compute_instance.server.network_interface.0.nat_ip_address
}


output "server_id" {
  value = yandex_compute_instance.server.id
}

output "server_name" {
  value = yandex_compute_instance.server.name
}

output "server_status" {
  value = yandex_compute_instance.server.status
}
```

```/test/modules/servers/main.tf```
``` 
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# Подготовка виртуальной машины Ubuntu core 2 memory 2 20% core using 
resource "yandex_compute_instance" "server" {
  name        = "${var.server-app-name}-server"
  hostname    = var.server-host-name
  platform_id = "standard-v3"

  # вычислительные мощности машины
  resources {
    core_fraction = var.core_fraction
    cores         = 2
    memory        = 2
  }

  # какой образ будем грузить
  boot_disk {
    initialize_params {
      # image_id = data.yandex_compute_image.ubuntu_image
      image_id = "fd8g5aftj139tv8u2mo1"
    }
  }

  network_interface {
    subnet_id = var.servers_subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta/user.meta.yaml")}"
  }
}
```

Далее производим настройку возводимого окружения. Там так же пристутсвую файлы для описания переменных, выходных данных и метаинформация создоваемых пользователей на серверах.

```/test/live/stage/variables.tf```
```
# Список переменных для данного окружения
variable "zone" {
  description = "network-zone, ru-central1-a or ru-central1-b or ru-central1-c"
  default     = "ru-central1-b"
  type        = string
}

variable "network-name" {
  description = "Network name"
  type        = string
}

variable "subnet-name" {
  description = "Subnet name"
  type        = string
}

variable "v4_cidr_blocks" {
  description = "pool of ipv4 addresses, e.g "
  type        = string
}

variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор зоны"
  type        = string
}

variable "service_account_key_file" {
  description = "Укажите путь до файла с ключом к доступу в облако для сервисного аккаунта"
  type        = string
}
```

```/test/live/stage/outputs.tf``` 
``` 
output "external_ip_address_server" {
  value = module.nginx-server.external_ip_address_server
}

output "internal_ip_address_server" {
  value = module.nginx-server.internal_ip_address_server
}

output "server_id" {
  value = module.nginx-server.server_id
}

output "server_name" {
  value = module.nginx-server.server_name
}

output "server_status" {
  value = module.nginx-server.server_status
}

output "network_id" {
  value = module.adn-networks.network_id
}

output "network_name" {
  value = module.adn-networks.network_name
}

output "subnet_id" {
  value = module.adn-networks.subnet_id
}


output "subnet_name" {
  value = module.adn-networks.subnet_name
}
```

```/test/live/stage/terraform.tfvars```
```
# Список предзаполненых переменных
cloud_id = "b1g3menglg4ufpjgjsho"
folder_id = "b1grctf7tvhjcshed89i"
network-name = "adn-network"
subnet-name = "adn-subnet-network"
v4_cidr_blocks = "192.168.10.0/24"
```

```/test/live/stage/meta/user.meta.yaml``` Содержит информаицю о создоваемом пользователе на сервере
```yaml
#cloud-config
users:
  - name: user
    groups: sudo
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQA************//XOgaGDvynpDukW8fM= user@desktop
```

```/test/live/stage/main.tf```
``` 
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "adn-networks" {
  source                   = "./../../modules/networks"
  zone                     = var.zone
  network-name             = var.network-name
  subnet-name              = var.subnet-name
  v4_cidr_blocks           = var.v4_cidr_blocks
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_file
}

module "nginx-server" {
  source                   = "./../../modules/servers"
  core_fraction            = 20
  server-app-name          = "nginx"
  server-host-name         = "nginx"
  servers_subnet_id        = module.adn-networks.subnet_id
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_file
}
```

> За счет модулей удобно понимать, что именно мы создаем в нашем окружение, а именно сеть и один сервер. \
> Далее производим инициализацию, првоерку, планы и само создание: \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/bf61ce44-62c4-4ece-a7a7-9bdadd3e0593) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/9617d5c6-3e9d-4703-86c2-6533a9ca45b1) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/1909e430-2c26-4608-a928-9fcdfd62706f) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/7bcd5c9e-7647-43e1-b15c-3044f942ddc4) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/603dc128-683e-4db1-90a1-57eb3e5a7222) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/d918f271-f979-46a5-8ad9-7e87187a7781) \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/082e9037-5c40-4b85-83bd-e0e2179146bc) \

Инфраструктура подготовлена. Теперь с помощью Ansible накатить все остальное. \
Проект для ansible распологается в директории ```~/Projects/ansible/```
```/infra/inventory_yandex.ini```
```ini
[nginx]
158.160.29.120 ansible_user=user
```

```/playbooks/nginx.playbook.yaml```
```yaml
---
- hosts: nginx
  become: true
  remote_user: user
  tasks:
    - name: "Install nginx"
      apt:
        name: "nginx"
        state: "latest"
        update_cache: true
    - service:
        name: "nginx"
        state: started
      become: true
      become_method: sudo

```

Запускаем плейбук: \
![image](https://github.com/ADNikulin/netology/assets/44374132/4596b27e-c3a3-4273-971d-e43d3b913287) \
![image](https://github.com/ADNikulin/netology/assets/44374132/8a115f98-0c2c-4eeb-88ab-d14c2acbb071) \
![image](https://github.com/ADNikulin/netology/assets/44374132/f619c9d2-b641-436e-9ac3-08e500dfaa18)


## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.лнить, если хотите глубже и/или шире разобраться в материале.

--- 
### Задание 2*

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

1. Перестроить инфраструктуру и добавить в неё вторую виртуальную машину. 
2. Установить на вторую виртуальную машину базу данных. 
3. Выполнить проверку состояния запущенных служб через Ansible.

### Решение 2*

--- 
### Задание 3*
Изучите [инструкцию](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart) yandex для terraform.
Добейтесь работы паплайна с безопасной передачей токена от облака в terraform через переменные окружения. Для этого:

1. Настройте профиль для yc tools по инструкции.
2. Удалите из кода строчку "token = var.yandex_cloud_token". Terraform будет считывать значение ENV переменной YC_TOKEN.
3. Выполните команду export YC_TOKEN=$(yc iam create-token) и в том же shell запустите terraform.
4. Для того чтобы вам не нужно было каждый раз выполнять export - добавьте данную команду в самый конец файла ~/.bashrc

### Решение 3*
---

Дополнительные материалы: 

1. [Nginx. Руководство для начинающих](https://nginx.org/ru/docs/beginners_guide.html). 
2. [Руководство по Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/doc). 
3. [Ansible User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html).
1. [Terraform Documentation](https://www.terraform.io/docs/index.html).
