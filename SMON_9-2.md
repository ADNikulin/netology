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

  Второе задание решил сделать через ansibleб что бы расскатать сразу все настройки на пару серверов. \
  Список серверов: \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/1691b0ff-baa0-4425-87dd-16fed53cce5c)

  - **Подготовил плейбук с инфрой**
    - inventory: \
      ```ini
      [client_zabbix]
      158.160.77.153 ansible_user=user
      84.201.162.178 ansible_user=user
      ```
    - playbook: \
      ```yaml
      ---
      - name: Install zabbix on debian 11
        hosts: client_zabbix
        become: true
        remote_user: user
        vars:
          zabix_agent_deb_url: https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4+debian11_all.deb
          zabix_server_url: "10.129.0.19"
        tasks:
          - name: wget zabbix repo
            get_url:
              url: "{{ zabix_agent_deb_url }}"
              dest: /tmp/zabbix_agent.deb
      
          - name: install zabbix repo
            apt: 
              deb: /tmp/zabbix_agent.deb
              state: present
          
          - name: update apt get and install zabbix agent 
            apt: 
              name: zabbix-agent
              state: present
              update_cache: yes
      
          - name: Stop service zabbix-agent
            service:
              name: zabbix-agent
              state: stopped
      
          - name: Set to config file ip zabbix server 
            shell: sed -i 's/Server=127.0.0.1/Server=127.0.0.1,{{ zabix_server_url }}/g' /etc/zabbix/zabbix_agentd.conf
      
          - name: Start service zabbix-agent
            service: 
              name: zabbix-agent
              enabled: true
              state: started
      ```
    - Проверяем корректность конфигов: \
      ![image](https://github.com/ADNikulin/netology/assets/44374132/9dcc65fe-9c76-4ef5-8b73-10b88bcde08d)
    - Проверяем запущен ли забикс агент: \
      ![image](https://github.com/ADNikulin/netology/assets/44374132/c4659fec-f8ed-41cf-a62a-4dbb5f8b0948)
  - **Настраиваем WEB часть**
    - Configuration Host: \
      ![image](https://github.com/ADNikulin/netology/assets/44374132/2b2b27cc-d42b-41f0-abc8-9bee11cfcf07)
    - Latest data: \
      ![image](https://github.com/ADNikulin/netology/assets/44374132/b0c3c1e3-4a66-4725-b752-c0064fde4735)
    - Логи с машины: \
      ![image](https://github.com/ADNikulin/netology/assets/44374132/da3abc40-181f-4df3-b6b7-7361b4cba49d)

</details>

---
### Задание 3 со звёздочкой*
Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

## Требования к результаты 
1. Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:

### Решение 3

<details>
  <summary>Решение</summary>

  Подопотной машины с виндой нет) а гемороится с собственной машиной и пробросом портов без белого ip - желания нет) 
</details>
