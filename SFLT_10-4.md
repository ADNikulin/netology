# Домашнее задание к занятию «Отказоустойчивость в облаке»

### Цель задания

В результате выполнения этого задания вы научитесь:  
1. Конфигурировать отказоустойчивый кластер в облаке с использованием различных функций отказоустойчивости. 
2. Устанавливать сервисы из конфигурации инфраструктуры.

---

## Задание 1 

Возьмите за основу [решение к заданию 1 из занятия «Подъём инфраструктуры в Яндекс Облаке»](https://github.com/netology-code/sdvps-homeworks/blob/main/7-03.md#задание-1).

1. Теперь вместо одной виртуальной машины сделайте terraform playbook, который:

- создаст 2 идентичные виртуальные машины. Используйте аргумент [count](https://www.terraform.io/docs/language/meta-arguments/count.html) для создания таких ресурсов;
- создаст [таргет-группу](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group). Поместите в неё созданные на шаге 1 виртуальные машины;
- создаст [сетевой балансировщик нагрузки](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer), который слушает на порту 80, отправляет трафик на порт 80 виртуальных машин и http healthcheck на порт 80 виртуальных машин.

Рекомендуем изучить [документацию сетевого балансировщика нагрузки](https://cloud.yandex.ru/docs/network-load-balancer/quickstart) для того, чтобы было понятно, что вы сделали.

2. Установите на созданные виртуальные машины пакет Nginx любым удобным способом и запустите Nginx веб-сервер на порту 80.

3. Перейдите в веб-консоль Yandex Cloud и убедитесь, что: 

- созданный балансировщик находится в статусе Active,
- обе виртуальные машины в целевой группе находятся в состоянии healthy.

4. Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

*В качестве результата пришлите:*

*1. Terraform Playbook.*

*2. Скриншот статуса балансировщика и целевой группы.*

*3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.*

## Решение 1 

<details>
  <summary>Решение</summary>

  - С терраформом не стал заморачиваться и написал линейный скрипт. Соответсвенно в файле meta.yaml, настрйоки пользователя для доступа по ssh.
  - Для устанвоки Nginx использовал ранее заготовленные плейбуки. 
  - terraform playbook:
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
      zone = "ru-central1-b"
    }
    
    resource "yandex_compute_instance" "server" {
      count = 2
      name = "server${count.index}"
      platform_id = "standard-v3"
    
      resources {
        core_fraction = 20
        cores = 2
        memory = 2
      }
    
      boot_disk {
        initialize_params {
            image_id = "fd8g5aftj139tv8u2mo1"
            size = 10
        }
      }
    
      network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat = true
      }
    
      placement_policy {
        placement_group_id = "${yandex_compute_placement_group.group1.id}"
      }
    
      metadata = {
        user-data = file("./meta.yaml")
      }
    }
    
    resource "yandex_compute_placement_group" "group1" {
      name="test-pg1"
    }
    
    resource "yandex_vpc_network" "network-1"{
      name = "network1"
    }
    
    resource "yandex_vpc_subnet" "subnet-1"{
      name           = "subnet1"
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["192.168.10.0/24"]
      network_id     = "${yandex_vpc_network.network-1.id}"
    }
    
    
    resource "yandex_lb_network_load_balancer" "lb-1" {
      name = "lb-1"
      listener {
        name = "my-lb1"
        port = 80
        external_address_spec {
          ip_version = "ipv4"
        }
      }
      attached_target_group {
        target_group_id = yandex_lb_target_group.test-1.id
        healthcheck {
          name = "http"
          http_options {
            port = 80
            path = "/"
          }
        }
      }
    }
    
    resource "yandex_lb_target_group" "test-1" {
      name      = "test-1"
      target {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        address   = yandex_compute_instance.server[0].network_interface.0.ip_address
      }
      target {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        address   = yandex_compute_instance.server[1].network_interface.0.ip_address
      }
    }
    ```
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/c5f6aecc-c26c-46e2-879d-393c2c95b21c)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/2e56057d-666f-4ec8-a6f1-0e57de16b29a)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/a877e865-0a68-4fb9-99e2-82d2ccf8f287)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/3729f894-86bb-46ad-95d9-5eec16e021a0)


</details>

---

## Задания со звёздочкой*
Эти задания дополнительные. Выполнять их не обязательно. На зачёт это не повлияет. Вы можете их выполнить, если хотите глубже разобраться в материале.

---

## Задание 2*

1. Теперь вместо создания виртуальных машин создайте [группу виртуальных машин с балансировщиком нагрузки](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

2. Nginx нужно будет поставить тоже автоматизированно. Для этого вам нужно будет подложить файл установки Nginx в user-data-ключ [метадаты](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata) виртуальной машины.

- [Пример файла установки Nginx](https://github.com/nar3k/yc-public-tasks/blob/master/terraform/metadata.yaml).
- [Как подставлять файл в метадату виртуальной машины.](https://github.com/nar3k/yc-public-tasks/blob/a6c50a5e1d82f27e6d7f3897972adb872299f14a/terraform/main.tf#L38)

3. Перейдите в веб-консоль Yandex Cloud и убедитесь, что: 

- созданный балансировщик находится в статусе Active,
- обе виртуальные машины в целевой группе находятся в состоянии healthy.

4. Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

*В качестве результата пришлите*

*1. Terraform Playbook.*

*2. Скриншот статуса балансировщика и целевой группы.*

*3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.*

## Решение 2*

<details>
  <summary>Решение</summary>

  - Стандартная схема, в яндексе нашел как это делать, реализовал натсроил.
  - С помощью ансибл накатил на 3 машины nginx 
  - ```
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    
      required_version = ">= 0.13"
    }
    
    provider "yandex" {
      zone = "ru-central1-b"
    }
    
    resource "yandex_iam_service_account" "ig-sa" {
      name        = "ig-sa"
      description = "service account to manage IG"
    }
    
    resource "yandex_resourcemanager_folder_iam_member" "editor" {
      folder_id = "****"
      role      = "editor"
      member   = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
      depends_on = [
        yandex_iam_service_account.ig-sa,
      ]
    }
    
    resource "yandex_compute_instance_group" "ig-1" {
      name               = "fixed-ig-with-balancer"
      folder_id = "******"
      service_account_id = "${yandex_iam_service_account.ig-sa.id}"
      depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
      instance_template {
        platform_id = "standard-v3"
        resources {
          memory = 2
          cores  = 2
          core_fraction = 20
        }
    
        boot_disk {
          mode = "READ_WRITE"
          initialize_params {
            image_id = "fd8g5aftj139tv8u2mo1"
          }
        }
    
        network_interface {
          network_id = "${yandex_vpc_network.network-1.id}"
          subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
          nat = true
        }
    
        metadata = {
          user-data = file("./meta.yaml")
        }
      }
    
      scale_policy {
        fixed_scale {
          size = 3
        }
      }
    
      allocation_policy {
        zones = ["ru-central1-b"]
      }
    
      deploy_policy {
        max_unavailable = 1
        max_expansion   = 0
      }
    
      load_balancer {
        target_group_name        = "target-group"
        target_group_description = "load balancer target group"
      }
    }
    
    resource "yandex_lb_network_load_balancer" "lb-1" {
      name = "network-load-balancer-1"
    
      listener {
        name = "network-load-balancer-1-listener"
        port = 80
        external_address_spec {
          ip_version = "ipv4"
        }
      }
      attached_target_group {
        target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id
    
        healthcheck {
          name = "http"
          http_options {
            port = 80
            path = "/"
          }
        }
      }
    }
    
    resource "yandex_vpc_network" "network-1" {
      name = "network1"
    }
    
    resource "yandex_vpc_subnet" "subnet-1" {
      name           = "subnet1"
      zone           = "ru-central1-b"
      network_id     = "${yandex_vpc_network.network-1.id}"
      v4_cidr_blocks = ["192.168.10.0/24"]
    }
    ```
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/3859a841-810c-453f-a320-542bf5492621)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/e169bc9d-b596-4814-9b23-5b47c038967f)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/29c198e2-3156-4710-ba17-48b49ac1aefe)



  
</details>
