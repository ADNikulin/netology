# 10.2. Отказоустойчивость — Никулин Александр
# Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки»

---
### Задание 1
- Запустите два simple python сервера на своей виртуальной машине на разных портах
- Установите и настройте HAProxy, воспользуйтесь материалами к лекции по [ссылке](2/)
- Настройте балансировку Round-robin на 4 уровне.
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

### Решение 1
<details>
  <summary>Решение1</summary>
  
  - Конфиг haproxy.cfg
  ```
  global
  	log /dev/log	local0
  	log /dev/log	local1 notice
  	chroot /var/lib/haproxy
  	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
  	stats timeout 30s
  	user haproxy
  	group haproxy
  	daemon
  
  	# Default SSL material locations
  	ca-base /etc/ssl/certs
  	crt-base /etc/ssl/private
  	# See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
          ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
          ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
          ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets
  
  defaults
  	log	global
  	mode	http
  	option	httplog
  	option	dontlognull
          timeout connect 5000
          timeout client  50000
          timeout server  50000
  	errorfile 400 /etc/haproxy/errors/400.http
  	errorfile 403 /etc/haproxy/errors/403.http
  	errorfile 408 /etc/haproxy/errors/408.http
  	errorfile 500 /etc/haproxy/errors/500.http
  	errorfile 502 /etc/haproxy/errors/502.http
  	errorfile 503 /etc/haproxy/errors/503.http
  	errorfile 504 /etc/haproxy/errors/504.http
  
  listen stats  # веб-страница со статистикой
          bind                    :888
          mode                    http
          stats                   enable
          stats uri               /stats
          stats refresh           5s
          stats realm             Haproxy\ Statistics
  
  listen web_tcp
  	bind :8088
  
  	server s1 127.0.0.1:8888 check inter 3s
  	server s2 127.0.0.1:9999 check inter 3s
  ```
  - Результаты:
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/564d6972-25da-4c86-af06-387ede07c8cf)

</details>
---
### Задание 2
- Запустите три simple python сервера на своей виртуальной машине на разных портах
- Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
- HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

### Решение 2

<details>
  <summary>Решение 2</summary>

  - haproxy.cfg
    ```
    global
    	log /dev/log	local0
    	log /dev/log	local1 notice
    	chroot /var/lib/haproxy
    	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    	stats timeout 30s
    	user haproxy
    	group haproxy
    	daemon
    
    	# Default SSL material locations
    	ca-base /etc/ssl/certs
    	crt-base /etc/ssl/private
    
    	# See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
            ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
            ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
            ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets
  
    defaults
    	log	global
    	mode	http
    	option	httplog
    	option	dontlognull
      timeout connect 5000
      timeout client  50000
      timeout server  50000
    	errorfile 400 /etc/haproxy/errors/400.http
    	errorfile 403 /etc/haproxy/errors/403.http
    	errorfile 408 /etc/haproxy/errors/408.http
    	errorfile 500 /etc/haproxy/errors/500.http
    	errorfile 502 /etc/haproxy/errors/502.http
    	errorfile 503 /etc/haproxy/errors/503.http
    	errorfile 504 /etc/haproxy/errors/504.http
  
    frontend example  # секция фронтенд
      mode http
      bind :8080
  	  acl ACL_example hdr(host) -i example.local
  	  use_backend web_servers if ACL_example
  
    backend web_servers    # секция бэкенд
      mode http
      balance roundrobin
      server s1 127.0.0.1:8888 weight 2
      server s2 127.0.0.1:9999 weight 3
  	  server s3 127.0.0.1:7777 weight 4
    ```
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/5aa6ec91-67a5-47a9-8054-95177063bf80)

</details>
---

## Задания со звёздочкой*
Эти задания дополнительные. Их можно не выполнять. На зачёт это не повлияет. Вы можете их выполнить, если хотите глубже разобраться в материале.

---

### Задание 3*
- Настройте связку HAProxy + Nginx как было показано на лекции.
- Настройте Nginx так, чтобы файлы .jpg выдавались самим Nginx (предварительно разместите несколько тестовых картинок в директории /var/www/), а остальные запросы переадресовывались на HAProxy, который в свою очередь переадресовывал их на два Simple Python server.
- На проверку направьте конфигурационные файлы nginx, HAProxy, скриншоты с запросами jpg картинок и других файлов на Simple Python Server, демонстрирующие корректную настройку.

---

### Задание 4*
- Запустите 4 simple python сервера на разных портах.
- Первые два сервера будут выдавать страницу index.html вашего сайта example1.local (в файле index.html напишите example1.local)
- Вторые два сервера будут выдавать страницу index.html вашего сайта example2.local (в файле index.html напишите example2.local)
- Настройте два бэкенда HAProxy
- Настройте фронтенд HAProxy так, чтобы в зависимости от запрашиваемого сайта example1.local или example2.local запросы перенаправлялись на разные бэкенды HAProxy
- На проверку направьте конфигурационный файл HAProxy, скриншоты, демонстрирующие запросы к разным фронтендам и ответам от разных бэкендов.


------

### Правила приема работы

1. Необходимо следовать инструкции по выполнению домашнего задания, используя для оформления репозиторий Github
2. В ответе необходимо прикладывать требуемые материалы - скриншоты, конфигурационные файлы, скрипты. Необходимые материалы для получения зачета указаны в каждом задании.


------

### Критерии оценки

- Зачет - выполнены все задания, ответы даны в развернутой форме, приложены требуемые скриншоты, конфигурационные файлы, скрипты. В выполненных заданиях нет противоречий и нарушения логики
- На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки, приложены не все требуемые материалы.
