# 6.4. Виртуализация — Никулин Александр
# Домашнее задание к занятию «Docker. Часть 2»

### Задание 1

**Напишите ответ в свободной форме, не больше одного абзаца текста.**

Установите Docker Compose и опишите, для чего он нужен и как может улучшить вашу жизнь.

### Решение 1
> Предположим что у нас есть несколько сервисов и которые используется еще другие подсервисы. Для нормального функционирования общего сервиса необходимо что бы все они были запущены.
> Все сервисы разворачиваются с использованием докера. И вот что бы не разворачивать каждый компонент в ручную, то можно использовать docker compose.
> Т.е данная штука позволяет развернуть все сервисы, условно, одной командой.
> Технология Docker Compose, если описывать её упрощённо, позволяет, с помощью одной команды, запускать множество сервисов.
![image](https://github.com/ADNikulin/netology/assets/44374132/68aa39fd-778f-43d2-a898-bcb6616ad4ef)

---

### Задание 2 

**Выполните действия и приложите текст конфига на этом этапе.** 

Создайте файл docker-compose.yml и внесите туда первичные настройки: 

 * version;
 * services;
 * networks.

При выполнении задания используйте подсеть 172.22.0.0.
Ваша подсеть должна называться: <ваши фамилия и инициалы>-my-netology-hw.

### Решение 2

![image](https://github.com/ADNikulin/netology/assets/44374132/21c70fae-c10b-4002-a49a-b4b239b811e9)

---

### Задание 3 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите PostgreSQL с именем контейнера <ваши фамилия и инициалы>-netology-db. 
2. Предсоздайте БД <ваши фамилия и инициалы>-db.
3. Задайте пароль пользователя postgres, как <ваши фамилия и инициалы>12!3!!
4. Пример названия контейнера: ivanovii-netology-db.
5. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Решение 3

![image](https://github.com/ADNikulin/netology/assets/44374132/4af42c78-da70-4bb7-ab6b-a6aa442d9b27)

---

### Задание 4 

**Выполните действия:**

1. Установите pgAdmin с именем контейнера <ваши фамилия и инициалы>-pgadmin. 
2. Задайте логин администратора pgAdmin <ваши фамилия и инициалы>@ilove-netology.com и пароль на выбор.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.
4. Прокиньте на 80 порт контейнера порт 61231.

В качестве решения приложите:

* текст конфига текущего сервиса;
* скриншот админки pgAdmin.

### Решение 4

![image](https://github.com/ADNikulin/netology/assets/44374132/25705cd7-3632-42a0-b707-863e56e270b1)
![image](https://github.com/ADNikulin/netology/assets/44374132/950168c0-c38f-4b51-a85a-d8af5790ec75)

---

### Задание 5 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Server с именем контейнера <ваши фамилия и инициалы>-zabbix-netology. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Решение 5

![image](https://github.com/ADNikulin/netology/assets/44374132/28099192-39ab-4f97-b99f-d83e30a413b6)


---

### Задание 6

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Frontend с именем контейнера <ваши фамилия и инициалы>-netology-zabbix-frontend. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Решение 6

![image](https://github.com/ADNikulin/netology/assets/44374132/2a3a12c2-29bb-4da5-9ca4-1d219276011d)

---

### Задание 7 

**Выполните действия.**

Настройте линки, чтобы контейнеры запускались только в момент, когда запущены контейнеры, от которых они зависят.

В качестве решения приложите:

* текст конфига **целиком**;
* скриншот команды docker ps;
* скриншот авторизации в админке Zabbix.

### Решение 7

```
version: "3"
services:

  nikulinad-netology-db: 
    image: postgres:latest
    container_name: nikulinad-netology-db
    volumes:
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment:
      POSTGRES_PASSWORD: nikulinad12!3!!
      POSTGRES_DB: nikulinad_db
      PGDATA: /var/lib/postgresql/data/pgdata # Путь внутри контейнера, где будет папка pgdata
    ports:
      - 5432:5432
    networks:
      nikulinad-my-netology-hw:
        ipv4_address: 172.22.0.2

    restart: always # контейнер всегда будет перезапускаться

  nikulinad-netology-pgadmin: 
    image: dpage/pgadmin4
    links:
      - nikulinad-netology-db
    container_name: nikulinad-netology-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: nikulinad@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: nikulinad12!3!!
    ports:
      - 61231:80
    networks:
      nikulinad-my-netology-hw:
        ipv4_address: 172.22.0.3

    restart: always # контейнер всегда будет перезапускаться

  nikulinad-netology-zabbix:
    image: zabbix/zabbix-server-pgsql
    links:
      - nikulinad-netology-db
      - nikulinad-netology-pgadmin
    container_name: nikulinad-netology-zabbix
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: nikulinad12!3!!
    ports:
      - "10051:10051"
    networks:
      nikulinad-my-netology-hw:
        ipv4_address: 172.22.0.4
    restart: always

  nikulinad-netology-zabbix-frontend:
    image: zabbix/zabbix-web-apache-pgsql
    links: 
      - nikulinad-netology-db
      - nikulinad-netology-pgadmin
      - nikulinad-netology-zabbix
    container_name: nikulinad-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: nikulinad12!3!!
      ZBX_SERVER_HOST: 'zabbix_wgui'
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      nikulinad-my-netology-hw:
        ipv4_address: 172.22.0.5
    restart: always

networks:
  nikulinad-my-netology-hw:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.22.0.0/24
          gateway: 172.22.0.1
```

![image](https://github.com/ADNikulin/netology/assets/44374132/3ac72e68-1612-4834-a7bb-a2a0d4a266fe)
![image](https://github.com/ADNikulin/netology/assets/44374132/b2414775-d0d9-429c-85c8-69ccf09a1e56)

---

### Задание 8 

**Выполните действия:** 

1. Убейте все контейнеры и потом удалите их.
1. Приложите скриншот консоли с проделанными действиями.

### Решение 8

![image](https://github.com/ADNikulin/netology/assets/44374132/ba02b240-c86a-48fe-837b-60b1a4c477ad)

---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 9* 

Запустите свой сценарий на чистом железе без предзагруженных образов.

**Ответьте на вопросы в свободной форме:**

1. Сколько ушло времени на то, чтобы развернуть на чистом железе написанный вами сценарий?
2. Чем вы занимались в процессе создания сценария так, как это видите вы?
3. Что бы вы улучшили в сценарии развёртывания?
   
### Решение 9

> 1. Снес все контейнеры, образы и т.п. Запустил сценарий заново. На развертку всего ушло 2-4 минуты. Но думаю что кеши где-то были. Особено если учитывать что образы надо езе подятнуть. Так что думаю реально уйдет немного больше времени. В любом случае поднятие сервисов через докер компос, гораздо быстрее чем делать это ручками. 
> 2. Указывал какие сервисы устанавливаем, как они должны быть связанны между собой, настройка сетевых настроек с прокидыванием переменных окружения. Второй момент это отрабатывал сценарий и првоерял все ли параметры проброшены и укзааны правильно
> 3. Думаю что на данном этапе на этот вопрос не отвечу, т.к. для начала надо побольше с ним поработать и поустанавливать разные сервисы с использование докера. 
