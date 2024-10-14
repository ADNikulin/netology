# Микросервисы. Никулин Александр. 
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 
<details>
  <summary>Условия</summary>

  Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

  Решение должно соответствовать следующим требованиям:
  - маршрутизация запросов к нужному сервису на основе конфигурации,
  - возможность проверки аутентификационной информации в запросах,
  - обеспечение терминации HTTPS.

  Обоснуйте свой выбор.
</details>

<details>
  <summary>Решение</summary>

  В целом, на рынке такие решения называюся **API managment**. 
  Вот небольшой список таких решений. 

  | **Решение** | Маршрутизация запросов | Проверка аутентификации | Обеспечение терминации HTTPS |
  |---|---|---|---|
  | APIGee | ✔ | ✔ | ✔  |
  | Azure Gateway | ✔ | ✔ | ✔ | 
  | Apache APISIX | ✔ | ✔ | ✔ | 
  | Tibco Cloud API Management | ✔ | ✔ | ✔ | 
  | Axway | ✔ | ✔ | ✔ | 
  | Tyk | ✔ | ✔ | ✔ | 
  | NGINX | ✔ | ✔ | ✔ | 
  | NGINX Plus | ✔ | ✔ | ✔ | 
  | Gravitee | ✔ | ✔ | ✔ | 
  | AWS API Gateway | ✔ | ✔ | ✔ | 
  | Ambassador | ✔ | ✔ | ✔ |

  Ну и если говорить о выборе, то так как нет требований к стоимости продукта, а требования выше, это всего лишь маршрутизация, то я бы остановился исключительно на NGINX.
  *Из плюсов:*
  - Бесплатный;
  - Open Source;
  - Легковестный, быстрый, производительный;
  - Вышепоставленные задачи выполняет;
  - Так же легко интегрируется в системы логирования;

  *Из минусов:*
  - Нет веб интерфейса;
  - Работать с данной системой должен специалист понимающий спицифику сервисов;
  - Если говорить про монтезацию доступов к разному функционалу, то на мой взгляд, nginx не про это. 
</details>

## Задача 2: Брокер сообщений

<details>
  <summary>Условия</summary>

  Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

  Решение должно соответствовать следующим требованиям:
  - поддержка кластеризации для обеспечения надёжности,
  - хранение сообщений на диске в процессе доставки,
  - высокая скорость работы,
  - поддержка различных форматов сообщений,
  - разделение прав доступа к различным потокам сообщений,
  - простота эксплуатации.

  Обоснуйте свой выбор.

</details>

<details>
  <summary>Решение</summary>

  Небольшая выборка систем помогающих организовать шинну данных:

  | **Брокер сообщений** | Кластеризация | Хранение сообщений | Скорость работы | Поддержка форматов сообщений | Разделение прав доступа | Простота эксплуатации |
  |---|---|---|---|---|---|---|
  | Apache Kafka | Да | Да | Высокая | JSON, Avro, Protobuf, Binary | Да | Средняя |
  | RabbitMQ | Да | Да | Средняя | JSON, XML, AMQP, MQTT | Да | Высокая |
  | ActiveMQ | Да | Да | Средняя | JSON, XML, SOAP, STOMP | Да | Средняя |
  | Redis | Да | Нет | Высокая | JSON, Strings, Lists, Sets, Hashes | Нет | Высокая |
  | Beanstalk | Нет | Нет | Средняя | JSON, Strings | Нет | Средняя |

  > Если говорить про выбор, то тут надо смотерть как устроена текущая архитектура сервисов.\
  > В целом как такого предпочтения нет.. Но если бегло оценить то что можно было бы использовать, то выбор пал бы на системы на слуху. К приеру кафка или rabbit. \
  > И если речь пойдет к примеру о больших данных и большого потока обработки сообщений, то выбор падет на кафку. \
  > Если речь пойдет, о более простом использование шины данных, и более простом управление (через браузер и из коробки всё), то выбор падет на кролика.\
  > Так же стоит учитывать тот фактор, что rabbit реализует с самого начала протокол AMQP в отличие от кафки. У кафки свой протокол. И если требований к этому нет, то выбор падет на кафку. 


</details>

## Задача 3: API Gateway * (необязательная)

<details>
  <summary>Условие</summary>

  ### Есть три сервиса:

  **minio**
  - хранит загруженные файлы в бакете images,
  - S3 протокол,

  **uploader**
  - принимает файл, если картинка сжимает и загружает его в minio,
  - POST /v1/upload,

  **security**
  - регистрация пользователя POST /v1/user,
  - получение информации о пользователе GET /v1/user,
  - логин пользователя POST /v1/token,
  - проверка токена GET /v1/token/validation.

  ### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

  **POST /v1/register**
  1. Анонимный доступ.
  2. Запрос направляется в сервис security POST /v1/user.

  **POST /v1/token**
  1. Анонимный доступ.
  2. Запрос направляется в сервис security POST /v1/token.

  **GET /v1/user**
  1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
  2. Запрос направляется в сервис security GET /v1/user.

  **POST /v1/upload**
  1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
  2. Запрос направляется в сервис uploader POST /v1/upload.

  **GET /v1/user/{image}**
  1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
  2. Запрос направляется в сервис minio GET /images/{image}.

  ### Ожидаемый результат

  Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
  Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
  Авторизация
  curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

  **Загрузка файла**

  curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

  **Получение файла**
  curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

  ---

  #### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)
  
</details>

<details>
  <summary>Решение</summary>

  Пришлось слегка потенцивать с бубнами, что бы завести выше указанный стек:
  - Поднял виртуалку: 
  - ![alt text](img/image100.png)
  - Чутка переделал docker compose: [text](11-microservices-02-principles/docker-compose.yaml)
  - Исправил: [text](11-microservices-02-principles/security/requirements.txt)
  - Набросал кофинг для nginx: [text](11-microservices-02-principles/gateway/nginx.conf)
  - запустил всё: 
  - ![alt text](img/image99.png)
  - прверяю: 
  - ![alt text](img/image98.png)
  - ![alt text](img/image97.png)
  - ![alt text](img/image96.png)
</details>
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---