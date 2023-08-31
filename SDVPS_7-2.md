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
---
