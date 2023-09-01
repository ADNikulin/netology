# 7.2. Виртуализация — Никулин Александр
# Домашнее задание к занятию «Ansible.Часть 2»

---

### Задание 1

**Выполните действия, приложите файлы с плейбуками и вывод выполнения.**

Напишите три плейбука. При написании рекомендуем использовать текстовый редактор с подсветкой синтаксиса YAML.

Плейбуки должны: 

1. Скачать какой-либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать [официальный сайт](https://kafka.apache.org/downloads) и зеркало Apache Kafka. При этом можно скачать как исходный код, так и бинарные файлы, запакованные в архив — в нашем задании не принципиально.
2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его, как демон — конфигурационный файл systemd появится автоматически при установке. Добавить tuned в автозагрузку.
3. Изменить приветствие системы (motd) при входе на любое другое. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным способом.

### Решение 1
1. Первый плейбук:
```yaml
---
- name: install-kafka
  hosts: all
  become: yes
  tasks: 
    - name: Creates directory
      file:
        path: /var/tmp/bins
        state: directory
    - name: Download and unpack
      unarchive:
        src: https://downloads.apache.org/kafka/3.5.1/kafka-3.5.1-src.tgz
        dest: /var/tmp/bins
        remote_src: yes
```
![image](https://github.com/ADNikulin/netology/assets/44374132/a43b3957-4efd-40b4-ba2e-d1d3466827d6)
![image](https://github.com/ADNikulin/netology/assets/44374132/03c6e9df-3b47-41fe-8068-0fb29af2e7aa)

2. Второй плейбук:
```yaml
- name: install tuned
  hosts: all
  become: yes
  tasks: 
    - name: install
      apt: 
        name: 
          - tuned
        state: present
    - name: start service
      systemd:
        name: tuned
        state: started
        enabled: yes
```
![image](https://github.com/ADNikulin/netology/assets/44374132/c75806ba-d450-4294-90fd-9024f1f85db5)
![image](https://github.com/ADNikulin/netology/assets/44374132/0b6fcf09-b06c-4fde-bc07-7cf7d22d5f7a)

3. motd
```yaml
---
- name: change motd
  hosts: all
  become: true
  vars:
    path: /etc/update-motd.d/
  tasks:
    - name: Entrance change
      file:
        path: "{{path}}"
        mode: u=rw,g=rw,o=rw
        recurse: yes
```
![image](https://github.com/ADNikulin/netology/assets/44374132/83245d19-d723-43c1-a0d7-58be1bf0b5fb)
![image](https://github.com/ADNikulin/netology/assets/44374132/06984b43-3cd1-43ed-ad58-915df6163698)

---
### Задание 2

**Выполните действия, приложите файлы с модифицированным плейбуком и вывод выполнения.** 

Модифицируйте плейбук из пункта 3, задания 1. В качестве приветствия он должен установить IP-адрес и hostname управляемого хоста, пожелание хорошего дня системному администратору. 

### Решение 2
Подготовил файл: \
![image](https://github.com/ADNikulin/netology/assets/44374132/7b2d977c-d4c2-4c41-b075-2482aae213ba) \
Плейбук:
```yaml
---
- name: change motd
  hosts: all
  become: true
  vars:
    path: /etc/update-motd.d/
  tasks:
    - name: Entrance change
      file:
        path: "{{path}}"
        mode: u=rw,g=rw,o=rw
        recurse: yes
    - name: Add message
      template:
        src: /home/user/ansible_configs/motd.j2
        dest: /etc/motd
        mode: '644'
```
Результат:
![image](https://github.com/ADNikulin/netology/assets/44374132/5134a7eb-e42a-4c00-994c-dd4d88ee732b)
![image](https://github.com/ADNikulin/netology/assets/44374132/123b3c50-e72b-4040-8a3f-5590bdabf04e)


---
### Задание 3

**Выполните действия, приложите архив с ролью и вывод выполнения.**

Ознакомьтесь со статьёй [«Ansible - это вам не bash»](https://habr.com/ru/post/494738/), сделайте соответствующие выводы и не используйте модули **shell** или **command** при выполнении задания.

Создайте плейбук, который будет включать в себя одну, созданную вами роль. Роль должна:

1. Установить веб-сервер Apache на управляемые хосты.
2. Сконфигурировать файл index.html c выводом характеристик каждого компьютера как веб-страницу по умолчанию для Apache. Необходимо включить CPU, RAM, величину первого HDD, IP-адрес.
Используйте [Ansible facts](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html) и [jinja2-template](https://linuxways.net/centos/how-to-use-the-jinja2-template-in-ansible/). Необходимо реализовать handler: перезапуск Apache только в случае изменения файла конфигурации Apache.
4. Открыть порт 80, если необходимо, запустить сервер и добавить его в автозагрузку.
5. Сделать проверку доступности веб-сайта (ответ 200, модуль uri).

В качестве решения:
- предоставьте плейбук, использующий роль;
- разместите архив созданной роли у себя на Google диске и приложите ссылку на роль в своём решении;
- предоставьте скриншоты выполнения плейбука;
- предоставьте скриншот браузера, отображающего сконфигурированный index.html в качестве сайта.

### Решение 3
Подготовил папку на сервере, в ней запустил следующую команду: \
```ansible-galaxy init apache``` \
Получил роль: \
![image](https://github.com/ADNikulin/netology/assets/44374132/a472e9fc-9c07-4ff4-9d1a-c04dd3950041) \
Далее подготовил таски в роле: \
```install.yaml``` 
```yaml
# Устанавливаем последнюю версию Apache
- name: Install latest version of Apache
  apt: 
    name: apache2
    update_cache: yes
    state: latest
```

```service.yaml``` 
```yaml
# Стартуем сервис и добавляем в автозагрузку
- name: Start apache webserver
  service:
    name: apache2
    state: started
    enabled: true
```

```port.yaml``` 
```yaml
---
- name: wait for port 80 to become open
  wait_for:
    port: 80
    delay: 10
```

```prepare_index_html.yaml``` 
```yaml
---
# Подготавливаем файл индекс
- name: add the index page
  template:
    src: "index.html.j2"
    dest: "/var/www/html/index.html"
    owner: root
    group: root
    mode: 0755
```

```check_connection.yaml``` 
```yaml
---
- name: Check that you can connect (GET) to a page and it returns a status 200
  ansible.builtin.uri:
    url: "{{address}}"
  vars:
    address: "http://{{ ansible_facts.all_ipv4_addresses[0] }}"
```

Далее подготовил template:
```index.html.j2``` 
```j2
<html>
	<head>
		<title>{{ ansible_facts['fqdn'] }}</title>
	</head>
	<body>
		<h1>Hello to this Apache server!</h1>
		<p>Let's see this machine parameters:</p>
		<p>IP: {{ ansible_facts.all_ipv4_addresses[0] }}</p>
		<p>CPU: {{ ansible_facts.processor }}</p>
		<p>RAM_mb: {{ ansible_facts.memtotal_mb }}</p>
		<p>vda1_size: {{ ansible_facts['devices']['vda']['partitions']['vda1']['size'] }}</p>
	</body>
</html>
```

Далее подготовил ```main.yaml``` в тасках

```main.yaml``` 
```yaml
---
# Задачи для данной роли
  - import_tasks: install.yaml
  - import_tasks: service.yaml
  - import_tasks: port.yaml
  - import_tasks: prepare_index_html.yaml
  - import_tasks: check_connection.yaml
```

Плюс прописал отдельный ```inventory``` файл:

```ini
[apache]
10.129.0.30 ansible_user=user
10.129.0.4 ansible_user=user
```

Подготовил плейбук с ролью
```apache-playbook.yaml```
```yaml
- name: Ansible Playbook to Install and Setup Apache
  hosts: apache
  become: yes
  roles:
    - apache
```

Какая-то такая структура: \
![image](https://github.com/ADNikulin/netology/assets/44374132/62a253d9-ba81-4744-8c5f-2dcf378e9a49)


Ну и запуск плейбука:
```ansible-playbook -i inentory ./playbooks/apache-playbook.yaml```

Результат запуска:
![image](https://github.com/ADNikulin/netology/assets/44374132/07bd606e-95d5-42ee-903b-9e60406dd074) \
![image](https://github.com/ADNikulin/netology/assets/44374132/3ff184f4-a44e-4112-8bdc-877b98fc18dd) \
![image](https://github.com/ADNikulin/netology/assets/44374132/998c385c-d4ee-4827-8144-5577a2028d55) \

---
