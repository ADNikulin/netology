# 18.3 Виртуализация и контейнеризация.  Никулин Александр
# Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

## Задача 1
<details>
  <summary>Условия</summary>

  Сценарий выполнения задачи:
  - Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
  - Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: ```{"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}```
  - Зарегистрируйтесь и создайте публичный репозиторий  с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);
  - скачайте образ nginx:1.21.1;
  - Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
  ```
  <html>
  <head>
  Hey, Netology
  </head>
  <body>
  <h1>I will be DevOps Engineer!</h1>
  </body>
  </html>
  ```
  - Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП). 
  - Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

</details>

<details>
  <summary>Решение</summary>
  
  1. Подготовил виртуалку в яндексе: ![image](https://github.com/user-attachments/assets/3651e9ec-5b5b-49a0-b55a-cc8d910303cd)
  2. Установил докер на неё
     ```sh
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
     sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &&
     sudo docker run hello-world
     ```
  3. Подготовил докер файл и index.html \
     ![image](https://github.com/user-attachments/assets/2eecb576-029f-41d4-bb82-6a70a3c77fad) \
     Dockerfile без entrypoint и cmd так как принципиально от изначального контейненра ничего не меняем.
  4. ![image](https://github.com/user-attachments/assets/ff839d55-135b-40cc-bdd0-8ae9302ce1bf)
  5. ![image](https://github.com/user-attachments/assets/afe16ab6-0982-4b75-89b3-a8d25a0c80cc)
  6. ![image](https://github.com/user-attachments/assets/ce9a0b2e-fcde-4c24-b6da-60bff4c1d30d)
  7. [https://hub.docker.com/layers/ejick007/custom-nginx/general](https://hub.docker.com/repository/docker/ejick007/custom-nginx/general)

</details>

## Задача 2
<details>
  <summary>Условия</summary>
  
  1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
  - имя контейнера "ФИО-custom-nginx-t2"
  - контейнер работает в фоне
  - контейнер опубликован на порту хост системы 127.0.0.1:8080
  2. Не удаляя, переименуйте контейнер в "custom-nginx-t2"
  3. Выполните команду ```date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```
  4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.
  
  В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.
  
</details>

<details>
  <summary>Решение</summary>
  
</details>

## Задача 3
<details>
  <summary>Условия</summary>
  1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
  2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
  3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.
  4. Перезапустите контейнер
  5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
  6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
  7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
  8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.
  9. Выйдите из контейнера, набрав в консоли  ```exit``` или Ctrl-D.
  10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.
  11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. [пример источника](https://www.baeldung.com/linux/assign-port-docker-container)
  12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)
  
  В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

</details>

<details>
  <summary>Решение</summary>
  
</details>

## Задача 4
<details>
  <summary>Условия</summary>

  - Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
  - Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера. 
  - Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
  - Добавьте ещё один файл в текущий каталог ```$(pwd)``` на хостовой машине.
  - Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
  
  
  В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

</details>

<details>
  <summary>Решение</summary>
  
</details>

## Задача 5
<details>
  <summary>Условия</summary>

  1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него.
  "compose.yaml" с содержимым:
  ```
  version: "3"
  services:
    portainer:
      image: portainer/portainer-ce:latest
      network_mode: host
      ports:
        - "9000:9000"
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
  ```
  "docker-compose.yaml" с содержимым:
  ```
  version: "3"
  services:
    registry:
      image: registry:2
      network_mode: host
      ports:
      - "5000:5000"
  ```
  
  И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )
  
  2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)
  
  3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/
  4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)
  5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local  окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:
  
  ```
  version: '3'
  
  services:
    nginx:
      image: 127.0.0.1:5000/custom-nginx
      ports:
        - "9090:80"
  ```
  6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".
  
  7. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.
  
  В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.
</details>

<details>
  <summary>Решение</summary>
  
</details>
