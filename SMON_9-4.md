# 9.4. Мониторинг — Никулин Александр
# Домашнее задание к занятию «Система мониторинга Prometheus»
---

Это задание для самостоятельной отработки навыков и не предполагает обратной связи от преподавателя. Его выполнение не влияет на завершение модуля. Но мы рекомендуем его выполнить, чтобы закрепить полученные знания.

### Цели задания

1. Научиться устанавливать Prometheus
2. Научиться устанавливать Node Exporter
3. Научиться подключать Node Exporter к серверу Prometheus
4. Научиться устанавливать Grafana и интегрировать с Prometheus
---

### Задание 1*
Установите Prometheus.

#### Процесс выполнения
1. Выполняя задание, сверяйтесь с процессом, отражённым в записи лекции
2. Создайте пользователя prometheus
3. Скачайте prometheus и в соответствии с лекцией разместите файлы в целевые директории
4. Создайте сервис как показано на уроке
5. Проверьте что prometheus запускается, останавливается, перезапускается и отображает статус с помощью systemctl

#### Требования к результату
- [ ] Прикрепите к файлу README.md скриншот systemctl status prometheus, где будет написано: prometheus.service — Prometheus Service Netology Lesson 9.4 — [Ваши ФИО]

### Решение 1*

<details>
  <summary>Решение</summary>

  - Для установки прометеуса подготовил плейбук с ролями. 
  - Подготовил ВМ \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/cc584638-ed5b-4b9f-ac88-9f241b116056)
  - **Выжимка из роли:**
    - Inventory
      ```ini
      [prometheus_servers]
      62.84.120.51 ansible_user=user
      
      [node_exporter_servers]
      84.201.179.62 ansible_user=user
      130.193.43.82 ansible_user=user
      62.84.120.51 ansible_user=user
      
      [grafana_servers]
      62.84.120.51 ansible_user=user
      ```
    - .\roles\prometheus\templates\prometheus.service.j2
      ```ini
      [Unit]
      Description=Prometheus Service
      After=network.target
      
      [Service]
      User=prometheus
      Group=prometheus
      Type=simple
      ExecStart=/usr/local/bin/prometheus \
      --config.file /etc/prometheus/prometheus.yml \
      --storage.tsdb.path /var/lib/prometheus/ \
      --web.console.templates=/etc/prometheus/consoles \
      --web.console.libraries=/etc/prometheus/console_libraries
      ExecReload=/bin/kill -HUP $MAINPID Restart=on-failure
      Restart=on-failure
      
      [Install]
      WantedBy=multi-user.target
      ```
    - .\roles\prometheus\vars\main.yaml
      ```yaml
      ---
      # vars file for prometheus
      prometheus_version : 2.47.0
      ```
    - .\roles\prometheus\handlers\main.yaml
      ```yaml
      ---
      - name: systemd reload
        systemd:
          daemon_reload: yes
      ```
    - .\roles\prometheus\tasks\main.yaml
      ```yaml
      ---
      - name: Install Prometheus
        include_tasks: tasks/install_prometheus.yml
      ```
    - .\roles\prometheus\tasks\install_prometheus.yml
      ```yaml
      ---
      - name: Create User prometheus # Создаем пользователя prometheus.
        user:
          name: prometheus
          create_home: no
          shell: /bin/false
      
      - name: Create directories for prometheus #Создаем каталоги, в которые будут помещены файлы сервиса.
        file:
          path: "{{ item }}"
          state: directory
          owner: prometheus
          group: prometheus
        loop:
          - "/tmp/prometheus"
          - "/etc/prometheus"
          - "/var/lib/prometheus"
      
      - name: Download And Unzipped Prometheus # Скачиваем и распаковываем архив прометея с официального сайта.
        unarchive:
          src: "https://github.com/prometheus/prometheus/releases/download/v{{ prometheus_version }}/prometheus-{{ prometheus_version }}.linux-amd64.tar.gz"
          dest: /tmp/prometheus
          creates: /tmp/prometheus/prometheus-{{ prometheus_version }}.linux-amd64
          remote_src: yes
      
      - name: Copy Bin Files From Unzipped to Prometheus # Копируем бинарники
        copy:
          src: /tmp/prometheus/prometheus-{{ prometheus_version }}.linux-amd64/{{ item }}
          dest: /usr/local/bin/
          remote_src: yes
          mode: preserve
          owner: prometheus
          group: prometheus
        loop: ["prometheus", "promtool"]
      
      - name: Copy Conf Files From Unzipped to Prometheus # Копируем конфигурационные файлы.
        copy:
          src: /tmp/prometheus/prometheus-{{ prometheus_version }}.linux-amd64/{{ item }}
          dest: /etc/prometheus/
          remote_src: yes
          mode: preserve
          owner: prometheus
          group: prometheus
        loop: ["console_libraries", "consoles", "prometheus.yml"]
      
      - name: Create File for Prometheus Systemd # Создаем юнит service в systemd.
        template: 
          src: templates/prometheus.service.j2
          dest: /etc/systemd/system/prometheus.service
        notify:
          - systemd reload
      
      - name: Systemctl Prometheus Start 
        systemd:
          name: prometheus
          state: started
          enabled: yes

      ```
    - .\install_prometheus.playbook.yaml
      ```yaml
      ---
      - name: Install prometheus
        hosts: prometheus_servers
        become: true
        remote_user: user
        roles:
          - role: prometheus
      ```
  - После выполнения попадаем на сервер с прометеусом: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/a862a08d-a6f0-4135-a7ae-60ab423056ff)

</details>

---

### Задание 2*
Установите Node Exporter.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
3. Скачайте node exporter приведённый в презентации и в соответствии с лекцией разместите файлы в целевые директории
4. Создайте сервис для как показано на уроке
5. Проверьте что node exporter запускается, останавливается, перезапускается и отображает статус с помощью systemctl

#### Требования к результату
- [ ] Прикрепите к файлу README.md скриншот systemctl status node-exporter, где будет написано: node-exporter.service — Node Exporter Netology Lesson 9.4 — [Ваши ФИО]

### Решение 2*

<details>
  <summary>Решение</summary>

  - Для установки node-exporter так же подготовил плейбук с ролями. 
  - Подготовил ВМ \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/cc584638-ed5b-4b9f-ac88-9f241b116056)
  - **Выжимка из роли:**
    - Inventory
      ```ini
      [prometheus_servers]
      62.84.120.51 ansible_user=user
      
      [node_exporter_servers]
      84.201.179.62 ansible_user=user
      130.193.43.82 ansible_user=user
      62.84.120.51 ansible_user=user
      
      [grafana_servers]
      62.84.120.51 ansible_user=user
      ```
    - .\roles\node-exporter\templates\node-exporter.service.j2
      ```ini
      [Unit]
      Description=Node Exporter
      After=network.target
      
      [Service]
      User=prometheus
      Group=prometheus
      Type=simple
      ExecStart=/etc/prometheus/node-exporter/node_exporter
      
      [Install]
      WantedBy=multi-user.target
      ```
    - .\roles\node-exporter\vars\main.yaml
      ```yaml
      ---
      # vars file for prometheus
      node_exporter_version : 1.4.0
      url_node_exporter: https://github.com/prometheus/node_exporter/releases/download/v{{ node_exporter_version }}/node_exporter-{{ node_exporter_version }}.linux-amd64.tar.gz
      
      ```
    - .\roles\node-exporter\handlers\main.yaml
      ```yaml
      ---
      - name: systemd reload
        systemd:
          daemon_reload: yes
      ```
    - .\roles\node-exporter\tasks\main.yaml
      ```yaml
      ---
      # tasks file for node-exporter
      
      - name: Install Node exporter
        include_tasks: tasks/install_node_exporter.yml

      ```
    - .\roles\node-exporter\tasks\install_node_exporter.yml
      ```yaml
      ---
      - name: Create User prometheus # Создаем пользователя prometheus.
        user:
          name: prometheus
          create_home: no
          shell: /bin/false
      
      - name: Create directories for node-exporter #Создаем каталоги, в которые будут помещены файлы сервиса.
        file:
          path: "{{ item }}"
          state: directory
          owner: prometheus
          group: prometheus
        loop:
          - "/tmp/node-exporter"
          - "/etc/prometheus/node-exporter"
      
      - name: Download And Unzipped node-exporter # Скачиваем и распаковываем архив node-exporter с официального сайта.
        unarchive:
          src: "{{ url_node_exporter }}"
          dest: /tmp/node-exporter
          creates: /tmp/node-exporter/node_exporter-{{ node_exporter_version }}.linux-amd64
          remote_src: yes
      
      - name: Copy Bin Files From Unzipped to node-exporter # Копируем бинарники
        copy:
          src: /tmp/node-exporter/node_exporter-{{ node_exporter_version }}.linux-amd64/{{ item }}
          dest: /etc/prometheus/node-exporter/
          remote_src: yes
          mode: preserve
          owner: prometheus
          group: prometheus
        loop: ["node_exporter"]
      
      - name: Create File for node-exporter Systemd # Создаем юнит service в systemd.
        template: 
          src: templates/node-exporter.service.j2
          dest: /etc/systemd/system/node-exporter.service
        notify:
          - systemd reload
      
      - name: Systemctl node-exporter Start 
        systemd:
          name: node-exporter
          state: started
          enabled: yes
      ```
    - .\install_node_exporters.playbook.yaml
      ```yaml
      ---
      - name: Install node-exporters
        hosts: node_exporter_servers
        become: true
        remote_user: user
        roles:
          - role: node-exporter
      ```
  - Дергаем статус на соответствующих машинах: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/30c755ac-e58b-460b-82c7-69e26f9685d4)
  - Зашли на одну из машин по методу который отдает метрики: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/92088ce0-9770-41ca-9d19-e95fbba34da0)


</details>

---

### Задание 3*
Подключите Node Exporter к серверу Prometheus.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Отредактируйте prometheus.yaml, добавив в массив таргетов установленный в задании 2 node exporter
3. Перезапустите prometheus
4. Проверьте что он запустился

#### Требования к результату
- [ ] Прикрепите к файлу README.md скриншот конфигурации из интерфейса Prometheus вкладки Status > Configuration
- [ ] Прикрепите к файлу README.md скриншот из интерфейса Prometheus вкладки Status > Targets, чтобы было видно минимум два эндпоинта

### Решение 3

<details>
  <summary>Решение</summary>

  По хорошему надо было бы наверное еще накрутить какую-нить роль или плейбук по обновлению конфига, но тут обновил ручками конфиг прометеуса: \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/108d9982-b792-40ca-879a-196860409556) \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/e9aac3a1-005d-4bea-9ace-c95fb46d9001)

</details>

---
## Дополнительные задания со звёздочкой*
Эти задания дополнительные. Их можно не выполнять. Это не повлияет на зачёт. Вы можете их выполнить, если хотите глубже разобраться в материале.

---

### Задание 4*
Установите Grafana.

#### Требования к результату
- [ ] Прикрепите к файлу README.md скриншот левого нижнего угла интерфейса, чтобы при наведении на иконку пользователя были видны ваши ФИО

### Решение 4*

<details>
  <summary>Решение</summary>

  - Для установки grafana так же подготовил плейбук с ролями. 
  - Подготовил ВМ \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/cc584638-ed5b-4b9f-ac88-9f241b116056)
  - **Выжимка из роли:**
    - Inventory
      ```ini
      [prometheus_servers]
      62.84.120.51 ansible_user=user
      
      [node_exporter_servers]
      84.201.179.62 ansible_user=user
      130.193.43.82 ansible_user=user
      62.84.120.51 ansible_user=user
      
      [grafana_servers]
      62.84.120.51 ansible_user=user
      ```
      
    - .\roles\grafana\vars\main.yaml
      ```yaml
      ---
      # vars file for grafana
      
      grafana_version: 9.5.12
      grafana_deb_url: "https://dl.grafana.com/oss/release/grafana_{{ grafana_version }}_amd64.deb"
      ```
    - .\roles\grafana\handlers\main.yaml
      ```yaml
      ---
      - name: grafana systemd
      systemd:
        name: grafana-server
        enabled: yes
        state: started
      ```
    - .\roles\grafana\tasks\main.yaml
      ```yaml
      ---
      - name: Security Settings And Install Grafana For Debian
        block:
          - name: install libfontconfig1 and musl
            apt: 
              pkg:
                - libfontconfig1
                - musl
              state: present
              update_cache: true
      
          - name: download grafana deb
            get_url: 
              url: "{{ grafana_deb_url }}"
              dest: /tmp/grafana_{{ grafana_version }}_amd64.deb
      
          - name: install grafana repo
            apt: 
              deb: /tmp/grafana_{{ grafana_version }}_amd64.deb
              state: present
            notify:
              - grafana systemd
        when:
          ansible_os_family == "Debian"
      ```
    - .\install_grafana.playbook.yaml
      ```yaml
      ---
      - name: Install grafana
        hosts: grafana_servers
        become: true
        remote_user: user
        roles:
          - role: grafana
      ```
  - После установки захожу под админом, делаю новый логин и захожу под новым логином \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/4b0bcb83-9abd-43a2-8f35-b7214bcb92af)

</details>

---
### Задание 5*
Интегрируйте Grafana и Prometheus.

#### Требования к результату
- [ ] Прикрепите к файлу README.md скриншот дашборда (ID:11074) с поступающими туда данными из Node Exporter

### Решение 5*

<details>
  <summary>Решение</summary>

  ![image](https://github.com/ADNikulin/netology/assets/44374132/d4347416-1dd5-4151-b39b-72582da80930)

</details>
