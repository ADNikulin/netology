# 9.5. Мониторинг — Никулин Александр
# Домашнее задание к занятию «Prometheus. Часть 2»

Это задание для самостоятельной отработки навыков и не предполагает обратной связи от преподавателя. Его выполнение не влияет на завершение модуля. Но мы рекомендуем его выполнить, чтобы закрепить полученные знания.

### Цели задания
1. Научитья настраивать оповещения в Prometheus
2. Научиться устанавливать Alertmanager и интегрировать его с Prometheus
3. Научиться активировать экспортёр метрик в Docker и подключать его к Prometheus.
4. Научиться создавать дашборд Grafana

---

### Задание 1*
Создайте файл с правилом оповещения, как в лекции, и добавьте его в конфиг Prometheus.

### Требования к результату
- [ ] Погасите node exporter, стоящий на мониторинге, и прикрепите скриншот раздела оповещений Prometheus, где оповещение будет в статусе Pending

### Решение 1

<details>
  <summary>Решение</summary>
  
  - Использовал машины и обвязку нод из урока https://github.com/ADNikulin/netology/blob/master/SMON_9-4.md
  - Установил alertmanager на той же машине что прометеус сервер.
  - настроил конфиг alertmanager.yaml
    ```yaml
    global:
    route:
      group_by: ['alertname']
      group_wait: 30s
      group_interval: 10m
      repeat_interval: 60m
      receiver: 'email'
    receivers:
    - name: 'email'
      email_configs:
      - to: 'yourmailto@todomain.com'
        from: 'yourmailfrom@fromdomain.com'
        smarthost: 'mailserver:25'
        auth_username: 'user'
        auth_identity: 'user'
        auth_password: 'paS$w0rd'
    ```
  - Настроил prometheus.yaml
    ```yaml
    # my global config
    global:
      scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
      evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
      # scrape_timeout is set to the global default (10s).
    # Alertmanager configuration
    alerting:
      alertmanagers:
        - static_configs:
            - targets:
                - localhost:9093
              # - alertmanager:9093
    # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
    rule_files:
      - "netology-test.yaml"
      # - "first_rules.yml"
      # - "second_rules.yml"
    # A scrape configuration containing exactly one endpoint to scrape:
    # Here it's Prometheus itself.
    scrape_configs:
      # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
      - job_name: "prometheus"
        # metrics_path defaults to '/metrics'
        # scheme defaults to 'http'.
        static_configs:
          - targets: ["localhost:9090", "localhost:9100", "10.129.0.7:9100", "10.129.0.11:9100"]
    ```
  - Настроил **netology-test.yaml**
    ```yaml
    groups: 
    - name: netology-test 
      rules: 
      - alert: InstanceDown 
        expr: up == 0 
        for: 1m 
        labels:
          severity: critical
        annotations: 
          description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
          summary: Instance {{ $labels.instance }} down 
    ```
  - Погасил нод экспортер на локал хосте \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/8711a6a9-cd2f-433b-ab09-87ecb2aa8cd7)
  - Отработка алерт менеджера \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/5f710e0f-ce42-42bb-b211-7891eda3c823)

</details>


---

### Задание 2*
Установите Alertmanager и интегрируйте его с Prometheus.

### Требования к результату
- [ ] Прикрепите скриншот Alerts из Prometheus, где правило оповещения будет в статусе Fireing, и скриншот из Alertmanager, где будет видно действующее правило оповещения

### Решение 1

<details>
  <summary>Решение</summary>
  
  ![image](https://github.com/ADNikulin/netology/assets/44374132/f0029878-cc5c-48e7-8e73-a635814e856d) \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/5504a0dd-92a0-41cd-b91c-b5f6caf3d4e1) \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/7175aa10-457e-479a-bbf0-11ebbaa32b1e)

</details>
---

### Задание 3*

Активируйте экспортёр метрик в Docker и подключите его к Prometheus.

### Требования к результату
- [ ] приложите скриншот браузера с открытым эндпоинтом, а также скриншот списка таргетов из интерфейса Prometheus.*

### решение 4* 

<deatails>
  <summary>Решение</summary>
  
  - плейбук для установки докера
    ```
    - name: Install docker
      hosts: docker_servers
      become: true
      remote_user: user
      tasks:
        - name: instal aptitude for docker
          apt: 
            pkg:
              - apt-transport-https
              - ca-certificates 
              - curl 
              - lsb-release
              - gnupg-agent
              - software-properties-common
            state: present
            update_cache: true
    
        - name: Add Docker GPG apt Key
          apt_key:
            url: https://download.docker.com/linux/debian/gpg
            state: present
    
        - name: Add Docker Repository
          apt_repository:
            repo: deb https://download.docker.com/linux/debian stretch stable
            state: present
    
        - name: install docker
          apt:
            name: "{{item}}"
            state: latest
            update_cache: yes
          loop:
            - docker-ce
            - docker-ce-cli
            - containerd.io
    
        - name: add docker daemon.json
          template: 
            src: daemon.json.j2
            dest: /etc/docker/daemon.json
    
        - name: check docker is active
          systemd:
            name: docker
            state: started
            enabled: yes
    
        - name: Ensure group "docker" exists
          ansible.builtin.group:
            name: docker
            state: present
    ```
  - Файл настроек daemon.json.j2
    ```json
    {
        "metrics-addr": "0.0.0.0:9323",
        "experimental": true
    }
    ```
  - Правим основной файл (для сервера прометеус, который сожержит адреса, кого оправшивать), с новыми адресами: \
    ```yaml
    global:
      scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
      evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
    alerting:
      alertmanagers:
        - static_configs:
            - targets:
                - localhost:9093
    rule_files:
      - "netology-test.yaml"
    scrape_configs:
      - job_name: "prometheus"
        static_configs:
          - targets: ["localhost:9090", "localhost:9100", "localhost:9323", "10.129.0.7:9100", "10.129.0.7:9323", "10.129.0.11:9100", "10.129.0.11:9323"]
    ```
  - Запускаем плейбук и идме по одному их адресов для проверки метрик: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/b99709b8-9bd8-43f7-9c61-30547ed6d7fe)
  - Список таргетов: \
  ![image](https://github.com/ADNikulin/netology/assets/44374132/01e2c786-d182-43b8-a460-689449243d1a)

</deatails>

---

### Задание 4* со звездочкой 

Создайте свой дашборд Grafana с различными метриками Docker и сервера, на котором он стоит.

### Требования к результату
- [ ] Приложите скриншот, на котором будет дашборд Grafana с действующей метрикой

### Решение 4

<details>
  <summary>Решение </summary>

  - ![image](https://github.com/ADNikulin/netology/assets/44374132/440599a5-ecdd-49ca-8669-c19d1e628f51)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/0acd016b-4434-443f-8eb7-62145ba1951f)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/2a8380e2-3824-4458-a9c7-5b0b00bf341f)


  

</details>

## Критерии оценки
1. Выполнено минимум 3 обязательных задания
2. Прикреплены требуемые скриншоты
3. Задание оформлено в шаблоне с решением и опубликовано на GitHub
