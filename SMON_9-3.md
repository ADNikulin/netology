# 9.2. Мониторинг — Никулин Александр
# Домашнее задание к занятию «Система мониторинга Zabbix. Часть 2»

 ---
### Задание 1
Создайте свой шаблон, в котором будут элементы данных, мониторящие загрузку CPU и RAM хоста.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. В веб-интерфейсе Zabbix Servera в разделе Templates создайте новый шаблон
3. Создайте Item который будет собирать информацию об загрузке CPU в процентах
4. Создайте Item который будет собирать информацию об загрузке RAM в процентах

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот страницы шаблона с названием «Задание 1»

### Решение 1

<details>
  <summary>Решение</summary>

  ![image](https://github.com/ADNikulin/netology/assets/44374132/a1c62e95-0c70-49ee-aed4-e1788def2938)

</details>
 ---

### Задание 2
Добавьте в Zabbix два хоста и задайте им имена <фамилия и инициалы-1> и <фамилия и инициалы-2>. Например: ivanovii-1 и ivanovii-2.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 виртмашины, одной из них может быть ваш Zabbix Server
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera
5. Прикрепите за каждым хостом шаблон Linux by Zabbix Agent
6. Проверьте что в разделе Latest Data начали появляться данные с добавленных агентов

#### Требования к результату
- [ ] Результат данного задания сдавайте вместе с заданием 3

### Решение 2

<details>
  <summary>Решение</summary>
 
  - развернул пару новых серверов: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/1892dadd-1b85-4768-a718-97cfce9a9bf9)
  - накатил агенты на машины + добавил хосты \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/34b166de-90d4-49e2-bc8b-ce0953b61499)
  - Дождался данных: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/c9ab865e-290a-453f-a103-283335def33b)

</details>
 ---

### Задание 3
Привяжите созданный шаблон к двум хостам. Также привяжите к обоим хостам шаблон Linux by Zabbix Agent.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Зайдите в настройки каждого хоста и в разделе Templates прикрепите к этому хосту ваш шаблон
3. Так же к каждому хосту привяжите шаблон Linux by Zabbix Agent
4. Проверьте что в раздел Latest Data начали поступать необходимые данные из вашего шаблона

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот страницы хостов, где будут видны привязки шаблонов с названиями «Задание 2-3». Хосты должны иметь зелёный статус подключения

### Решение 3

<details>
  <summary>Решение</summary>

  - Добавил шаблон test_smon_9-3: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/f58d5e64-7ef5-4fd3-b62c-c95eb571b2b8)
  - Проверил Latest Data: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/922560a9-457e-496d-bbcd-ce68117a5db6)

</details>
 ---

### Задание 4
Создайте свой кастомный дашборд.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. В разделе Dashboards создайте новый дашборд
3. Разместите на нём несколько графиков на ваше усмотрение.

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот дашборда с названием «Задание 4»

### Решение 4

<details>
  <summary>Решение</summary>

  Чутка название не то дал) 
  ![image](https://github.com/ADNikulin/netology/assets/44374132/6d93ad4a-31c1-45a8-86c6-73713fd06815)

</details>
 ---

### Задание 5* со звёздочкой
Создайте карту и расположите на ней два своих хоста.

#### Процесс выполнения
1. Настройте между хостами линк.
2. Привяжите к линку триггер, связанный с agent.ping одного из хостов, и установите индикатором сработавшего триггера красную пунктирную линию.
3. Выключите хост, чей триггер добавлен в линк. Дождитесь срабатывания триггера.

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот карты, где видно, что триггер сработал, с названием «Задание 5» 

### Решение 5

<details>
  <summary>Решение</summary>

  - ![image](https://github.com/ADNikulin/netology/assets/44374132/b3ba6704-f1ce-4f5b-83df-85550a9c1bc0)
</details>
 ---

### Задание 6* со звёздочкой
Создайте UserParameter на bash и прикрепите его к созданному вами ранее шаблону. Он должен вызывать скрипт, который:
- при получении 1 будет возвращать ваши ФИО,
- при получении 2 будет возвращать текущую дату.

#### Требования к результату
- [ ] Прикрепите в файл README.md код скрипта, а также скриншот Latest data с результатом работы скрипта на bash, чтобы был виден результат работы скрипта при отправке в него 1 и 2

### Решение 6

<details>
  <summary>Решение</summary>

  - Создал на одном клиенте скрипт и UserParameter
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/2073f5ae-7e0a-4b76-8304-3225d67fb8f8)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/6ec6adcf-32b4-46d4-846b-8739b01970dc)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/59d39111-4d2a-4daa-8113-181e32d8fdc1)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/362db611-293c-4e6a-b7e9-27e140e299ec)
</details>
 ---

### Задание 7* со звёздочкой
Доработайте Python-скрипт из лекции, создайте для него UserParameter и прикрепите его к созданному вами ранее шаблону. 
Скрипт должен:
- при получении 1 возвращать ваши ФИО,
- при получении 2 возвращать текущую дату,
- делать всё, что делал скрипт из лекции.

- [ ] Прикрепите в файл README.md код скрипта в Git. Приложите в Git скриншот Latest data с результатом работы скрипта на Python, чтобы были видны результаты работы скрипта при отправке в него 1, 2, -ping, а также -simple_print.*

### Решение 7

<details>
  <summary>Решение</summary>

  - код питона:
    ```py
    import sys
    import os
    import re
    import datetime
        
    if (sys.argv[1] == '-ping'):
     result=os.popen("ping -c 1 " + sys.argv[2]).read()
     result=re.findall(r"time=(.*) ms", result)
     print(result[0])
    elif (sys.argv[1] == '-simple_print'):
     print(sys.argv[2])
    elif (sys.argv[1] == '1'):
     print('nikulin alexander dmitrievich')
    elif (sys.argv[1] == '2'):
     current_time = datetime.datetime.now()
     print(current_time)
    else:
     print(f"unknown input: {sys.argv[1]}")
    ```
  - обновил параметры на клиенте: \
    ![image](https://github.com/ADNikulin/netology/assets/44374132/f5e80412-ccd5-4d0e-9bb6-7ebfecac51d3)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/7810a0ed-d7e1-4c6e-9cb8-cbcecbaa0f5a)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/98e4feb7-8830-4a47-9745-d34797550d33)
</details>
 ---

### Задание 8* со звёздочкой

Настройте автообнаружение и прикрепление к хостам созданного вами ранее шаблона.

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот правила обнаружения, а также скриншот страницы Discover, где видны оба хоста.*

### Решение 8

<details>
  <summary>Решение</summary>

  - ![image](https://github.com/ADNikulin/netology/assets/44374132/ea4380b4-392d-48f7-a1d4-a4f8d8390cdc)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/9e7b4f64-f9f8-4d11-8cda-da778d849113)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/1d6be791-0206-4953-87af-19ce488a5d8f)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/d9183844-b161-421d-8f82-c1a89445139a)
</details>
 ---

### Задание 9* со звёздочкой

Доработайте скрипты Vagrant для 2-х агентов, чтобы они были готовы к автообнаружению сервером, а также имели на борту разработанные вами ранее параметры пользователей.

- [ ] Приложите в GitHub файлы Vagrantfile и zabbix-agent.sh.*

### Решение 9

<details>
  <summary>Решение</summary>

  - использовал ансибл:
  - inventory \
    ```ini
    [client_zabbix]
    158.160.77.153 ansible_user=user
    84.201.162.178 ansible_user=user
    51.250.102.170 ansible_user=user
    51.250.101.151 ansible_user=user
    ```
  - templates: \
   - user_parameters.conf.j2 \
     ```
     UserParameter=custom_py_text[*],python3 /etc/zabbix/zabbix_agentd.d/test_python_script.py -simple_print $1
     UserParameter=custom_py_fio[*],python3 /etc/zabbix/zabbix_agentd.d/test_python_script.py 1
     UserParameter=custom_py_date[*],python3 /etc/zabbix/zabbix_agentd.d/test_python_script.py 2
     UserParameter=custom_py_all[*],python3 /etc/zabbix/zabbix_agentd.d/test_python_script.py $1 $2
     ```
   - test_python_script.py.j2 \
     ```
     import sys
     import os
     import re
     import datetime
     
     if (sys.argv[1] == '-ping'):
      result=os.popen("ping -c 1 " + sys.argv[2]).read()
      result=re.findall(r"time=(.*) ms", result)
      print(result[0])
     elif (sys.argv[1] == '-simple_print'):
      print(sys.argv[2])
     elif (sys.argv[1] == '1'):
      print('nikulin alexander dmitrievich')
     elif (sys.argv[1] == '2'):
      current_time = datetime.datetime.now()
      print(current_time)
     else:
      print(f"unknown input: {sys.argv[1]}")
     ```
   - fio.sh.j2 \
     ```
     #!/bin/bash

    if [ $1 -eq "1" ]
    then
    	echo "alexander nikulin dmitrievich"
    elif [ $1 -eq "2" ]
    then
    	current=`date +%Y%m%d%H%M%S`
    	echo $current
    else
    	echo "incorrect params"
    fi
     ```
  - zabbix_aggent.yaml \
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
          
        - name: Create user parameters conf
          template:
            src: "../templates/user_parameters.conf.j2"
            dest: "/etc/zabbix/zabbix_agentd.d/user_parameters.conf"
    
        - name: Create scripts py
          template:
            src: "../templates/test_python_script.py.j2"
            dest: "/etc/zabbix/zabbix_agentd.d/test_python_script.py"
    
        - name: Create scripts bash
          template:
            src: "../templates/fio.sh.j2"
            dest: "/etc/zabbix/zabbix_agentd.d/fio.sh"
    
        - name: Start service zabbix-agent
          service: 
            name: zabbix-agent
            enabled: true
            state: started
            
    ```
</details>
