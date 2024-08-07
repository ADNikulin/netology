# 18.4 Виртуализация и контейнеризация.  Никулин Александр
# Домашнее задание к занятию 5. «Практическое применение Docker»

ссылка на репу: https://github.com/ADNikulin/shvirtd_18-4

## Задача 0
<details>
  <summary>Условия</summary>

  1. Убедитесь что у вас НЕ(!) установлен ```docker-compose```, для этого получите следующую ошибку от команды ```docker-compose --version```
  ```
  Command 'docker-compose' not found, but can be installed with:
  
  sudo snap install docker          # version 24.0.5, or
  sudo apt  install docker-compose  # version 1.25.0-1
  
  See 'snap info docker' for additional versions.
  ```
  В случае наличия установленного в системе ```docker-compose``` - удалите его.  
  2. Убедитесь что у вас УСТАНОВЛЕН ```docker compose```(без тире) версии не менее v2.24.X, для это выполните команду ```docker compose version```  
  
</details>
  
<details>
  <summary>Решение</summary>
    
  ![image](https://github.com/user-attachments/assets/efdffb45-2e79-4f9f-bd73-817a24c4769d)
  ![image](https://github.com/user-attachments/assets/d0164da7-79e2-4fd4-be49-b48f95e84b1b)
    
</details>

## Задача 1
<details>
  <summary>Условия</summary>

  1. Сделайте в своем github пространстве fork репозитория ```https://github.com/netology-code/shvirtd-example-python/blob/main/README.md```.   
  2. Создайте файл с именем ```Dockerfile.python``` для сборки данного проекта(для 3 задания изучите https://docs.docker.com/compose/compose-file/build/ ). Используйте базовый образ ```python:3.9-slim```. Протестируйте корректность сборки. Не забудьте dockerignore. 
  3. (Необязательная часть, *) Изучите инструкцию в проекте и запустите web-приложение без использования docker в venv. (Mysql БД можно запустить в docker run).
  4. (Необязательная часть, *) По образцу предоставленного python кода внесите в него исправление для управления названием используемой таблицы через ENV переменную.
</details>

<details>
  <summary>Решение</summary>

  * Подготовил текущую репу.
  * Подготовил файлы
    ** ![image](https://github.com/user-attachments/assets/ba6e0490-10ca-4077-b55e-e2daa21224ae)
    ** Докер файл 
      ```dockerfile
      FROM python:3.9-slim
      WORKDIR /app
      COPY requirements.txt ./
      RUN pip install -r requirements.txt
      COPY main.py ./
      CMD ["python", "main.py"]
      ```
  * Собрал образ
  * ![image](https://github.com/user-attachments/assets/1e6ee776-5064-4a6f-9fb1-b5fcb688bf20)
    
</details>

## Задача 2 (*)
<details>
  <summary>Условия</summary>  
  
  1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool".
       [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
  2. Настройте аутентификацию вашего локального docker в yandex container registry.
  3. Соберите и залейте в него образ с python приложением из задания №1.
  4. Просканируйте образ на уязвимости.
  5. В качестве ответа приложите отчет сканирования.
  
</details>

<details>
  <summary>Решение</summary>

  * Настроил хранилище контейнеров
  * загрузил туда образ собранного прилоежния
  * ![image](https://github.com/user-attachments/assets/7d6c5ea7-8783-4bbe-813b-0b8c67f7f17a)
  * Запустил сканирование
  * ![image](https://github.com/user-attachments/assets/5f258a26-f99f-4cad-b6d6-68089365b730)
  * ![image](https://github.com/user-attachments/assets/f0a32ce7-bf1d-4318-859e-fd169fa4aa62)
  * ну такое себе...
  * Отчет по сканированию: [тут](https://github.com/ADNikulin/shvirtd_18-4/blob/main/vulnerabilities.csv)
  
</details>

## Задача 3

<details>
  <summary>Условия</summary>
  
  1. Изучите файл "proxy.yaml"
  2. Создайте в репозитории с проектом файл ```compose.yaml```. С помощью директивы "include" подключите к нему файл "proxy.yaml".
  3. Опишите в файле ```compose.yaml``` следующие сервисы: 
    
  - ```web```. Образ приложения должен ИЛИ собираться при запуске compose из файла ```Dockerfile.python``` ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.5```. Сервис должен всегда перезапускаться в случае ошибок.
  Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса ```web``` 
    
  - ```db```. image=mysql:8. Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.10```. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте уже существующий .env file для назначения секретных ENV-переменных!
  4. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы: команда ```curl -L http://127.0.0.1:8090``` должна возвращать в качестве ответа время и локальный IP-адрес. Если сервисы не стартуют воспользуйтесь командами: ```docker ps -a ``` и ```docker logs <container_name>``` . Если вместо IP-адреса вы получаете ```None``` --убедитесь, что вы шлете запрос на порт ```8090```, а не 5000.
  5. Подключитесь к БД mysql с помощью команды ```docker exec <имя_контейнера> mysql -uroot -p<пароль root-пользователя>```(обратите внимание что между ключем -u и логином root нет пробела. это важно!!! тоже самое с паролем) . Введите последовательно команды (не забываем в конце символ ; ): ```show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;```.  
  6. Остановите проект. В качестве ответа приложите скриншот sql-запроса.
   
</details>

<details>
  <summary>Решение</summary>

  * Подготовил compose (В работе использовал registry от яндекса)
    ```yaml
    include:
      - proxy.yaml

    services:
      db:
        image: mysql:8
        command: --mysql-native-password=ON
        restart: on-failure
        env_file:
          - .env
        environment:
          - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
          - MYSQL_DATABASE=test_db
          - MYSQL_USER=test_db
          - MYSQL_PASSWORD=${MYSQL_PASSWORD}
          - MYSQL_ROOT_HOST="%"
        volumes:
          - ./docker_volumes/mysql:/var/lib/mysql:delegated
        ports:
          - 3306:3306
        networks:
          backend:
            ipv4_address: 172.20.0.10
    
      web:
        image: cr.yandex/crpfpe6a9e3kk9f8np39/ip_hunter:latest
        restart: on-failure
        environment:
          - DB_HOST=db
          - DB_USER=test_db
          - DB_PASSWORD=${MYSQL_PASSWORD}
          - DB_NAME=test_db
        depends_on:
          - db
        ports:
          - 5000:5000
        networks:
          backend:
            ipv4_address: 172.20.0.5
    
    networks:
      backend:
        driver: bridge
        ipam:
          config:
          - subnet: 172.20.0.0/24
    ```
    * добился стабильности
      ![image](https://github.com/ADNikulin/shvirtd_18-4/blob/main/img/image.png)
    * ![image](https://github.com/user-attachments/assets/e41fea45-8abc-4005-a469-60c8a9ab5bea)
    * ![image](https://github.com/user-attachments/assets/ac08f8d0-d918-4216-9993-101d41c42977)
    * ![image](https://github.com/user-attachments/assets/1d77ffc6-a1fb-4779-b94f-39ed341dfd08)
    * ![image](https://github.com/user-attachments/assets/83f95519-2067-4570-a3f1-0c62849e256a)

</details>

## Задача 4
<details>
  <summary>Условия</summary>
  
  1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
  2. Подключитесь к Вм по ssh и установите docker.
  3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
  4. Зайдите на сайт проверки http подключений, например(или аналогичный): ```https://check-host.net/check-http``` и запустите проверку вашего сервиса ```http://<внешний_IP-адрес_вашей_ВМ>:8090```. Таким образом трафик будет направлен в ingress-proxy.
  5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения ```docker ps -a```
  6. В качестве ответа повторите  sql-запрос и приложите скриншот с данного сервера, bash-скрипт и ссылку на fork-репозиторий.

</details>
  
<details>
  <summary>Решение</summary>

  * Разработка и так велась на яндекс ВМ \
    ![image](https://github.com/ADNikulin/shvirtd_18-4/blob/main/img/image1.png)
  * Каталог только другой, думаю роли не сыграет \
    ![image](https://github.com/ADNikulin/shvirtd_18-4/blob/main/img/image2.png)
  * ![alt text](https://github.com/ADNikulin/shvirtd_18-4/blob/main/img/image3.png)
  * ![alt text](https://github.com/ADNikulin/shvirtd_18-4/blob/main/img/image4.png)
  * ![image](https://github.com/user-attachments/assets/6ff7bf9f-58a6-4d4d-b298-af345a9eac14)
  * ссылка на репозиторий: https://github.com/ADNikulin/shvirtd_18-4
  * ```sh
    #!/bin/bash

    if ! command -v docker &> /dev/null
    then
      #!/bin/bash

      # Add Docker's official GPG key:
      sudo apt-get update &&
      sudo apt-get install ca-certificates curl gnupg -y &&
      sudo install -m 0755 -d /etc/apt/keyrings &&
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&
      sudo chmod a+r /etc/apt/keyrings/docker.gpg &&

      # Add the repository to Apt sources:
      echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
      sudo apt-get update &&
      sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin &&
    fi

    if [ ! -d "/opt/shvirtd-example-python" ] ; then
        sudo git clone https://github.com/ADNikulin/shvirtd_18-4.git /opt/shvirtd-example-python
    else
        cd /opt/shvirtd-example-python
        sudo git pull
    fi

    cd /opt/shvirtd-example-python

    sudo docker-compose -f compose.yaml up -d
    ```
    
</details>

## Задача 5 *
<details>
  <summary>Условия</summary>
  
  1. Напишите и задеплойте на вашу облачную ВМ bash скрипт, который произведет резервное копирование БД mysql в директорию "/opt/backup" с помощью запуска в сети "backend" контейнера из образа ```schnitzler/mysqldump``` при помощи ```docker run ...``` команды. Подсказка: "документация образа."
  2. Протестируйте ручной запуск
  3. Настройте выполнение скрипта раз в 1 минуту через cron, crontab или systemctl timer. Придумайте способ не светить логин/пароль в git!!
  4. Предоставьте скрипт, cron-task и скриншот с несколькими резервными копиями в "/opt/backup"

</details>
  
<details>
  <summary>Решение</summary>

  За основу взят: https://hub.docker.com/r/schnitzler/mysqldump/#!

  Разовый скрипт копирования
  ```
  docker run \
    --rm --entrypoint "" \
    -v `pwd`/opt/backup:/backup \
    --link="shvirtd_18-4-db-1" \
    --net shvirtd_18-4_backend \
    schnitzler/mysqldump \
    mysqldump --opt -h db -u root -pYtReWq4321 "--result-file=/backup/dumps.sql" database
  ```

  Отдельный компоуз файл:
  ```
  services:
    cron:
      image: schnitzler/mysqldump
      restart: always
      volumes:
        - ./bin/crontab:/var/spool/cron/crontabs/root
        - ./bin/backup:/usr/local/bin/backup
      volumes_from:
        - backup
      env_file:
        - .env
      command: ["-l", "8", "-d", "8"]
      environment:
        MYSQL_HOST: db
        MYSQL_USER: root
        MYSQL_PASSWORD: ${MYSQL_PASSWORD}
        MYSQL_DATABASE: test_db
      networks:
        backend:
          ipv4_address: 172.20.0.3
    backup:
      image: busybox
      volumes:
        - /opt/backup:/backup
  ```

  Со структурой папок: 
  * ![image](https://github.com/user-attachments/assets/62b31cdb-9d5f-48e7-a575-4069da86b11f)
  * ![image](https://github.com/user-attachments/assets/ba1ebf16-fcae-4c4d-8526-b316de4da576)
  * ![image](https://github.com/user-attachments/assets/1e4e8f83-a704-44a2-b0c1-64ced1074e3d)
      
</details>
