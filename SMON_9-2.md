# 9.2. Мониторинг — Никулин Александр
# Домашнее задание к занятию «Система мониторинга Zabbix»
---

### Задание 1 

Установите Zabbix Server с веб-интерфейсом.

#### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
3. Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
4. Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

#### Требования к результаты 
1. Прикрепите в файл README.md скриншот авторизации в админке.
2. Приложите в файл README.md текст использованных команд в GitHub.

### Решение 1

<details>
  <summary>Решение</summary>

  Используем конфигуратор отсюда `https://www.zabbix.com/ru/download?zabbix=6.0&os_distribution=debian&os_version=11&components=server_frontend_agent&db=pgsql&ws=apache` \
  - Команды:
    - **Устанавливаем postgresql**
      - `apt update`
      - `apt install postgresql`
    - **Устанваливаем zabbix**
      - `wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4+debian11_all.deb`
      - `dpkg -i zabbix-release_6.0-4+debian11_all.deb`
      - `apt update`
      - `apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent`
      - `less /etc/passwd | grep postgre` На всякий пожарный проверяем что пользователь postgres создан
    - **Создаем пользователя в бд и саму базу**
      - `su - postgres -c 'psql --command "CREATE USER zabbix WITH PASSWORD '\'123456789\'';"'`
      - `su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"'`
    - **Готовим все остальное**
      `zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix` импортируем начальную схему и данные.
      `find / -name zabbix_server.conf` - ищем где лежит файл конфигурации для редактирования пароля для доступа к бд
      `sed -i 's/# DBPassword=/DBPassword=123456789/g' /etc/zabbix/zabbix_server.conf` - Устанавливаем пароль
      `systemctl restart zabbix-server zabbix-agent apache2` - Стартуем сервис
      `systemctl enable zabbix-server zabbix-agent apache2` - Добавляем в автозапуск
      `systemctl status zabbix-server.service` - Проверяем что все ок
   - Далее подключаемся к к забиксу по `http://<ip>/zabbix/`
     - Проивзовдим базовую настрйоку указызваея пароли к БД и т.п.
     - И логинимся под Admin/zabbix
     - ![image](https://github.com/ADNikulin/netology/assets/44374132/8810d43d-f54c-4af1-8ccb-3b2eb50635fd)
     - ![image](https://github.com/ADNikulin/netology/assets/44374132/cb2f02de-914a-4cab-9971-100f8eed731e)
</details>

---

### Задание 2 

Установите Zabbix Agent на два хоста.

#### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
5. Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

#### Требования к результаты 
1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
4. Приложите в файл README.md текст использованных команд в GitHub

### Решение 2

<details>
  <summary>Решение</summary>
  
</details>
---
## Задание 3 со звёздочкой*
Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

#### Требования к результаты 
1. Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:
--- 

### Решение 3

<details>
  <summary>Решение</summary>
  
</details>
