# Система управления конфигурациями. Никулин Александр. 
# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению
<details>
  <summary>Детали</summary>

  1. Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman"`.
  2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

</details>

## Основная часть
<details>
  <summary>Детали</summary>

  Ваша цель — настроить тестирование ваших ролей. 
  Задача — сделать сценарии тестирования для vector. 
  Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

</details>

## Molecule
<details>
  <summary>Детали</summary>

  Выполняется всё в репе: https://github.com/ADNikulin/ansible-vector-role/

  1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.

     ```
     user@ansible3:/home/user/ansible-clickhouse/$ molecule test -s ubuntu_xenial
     WARNING  Driver docker does not provide a schema.
     CRITICAL Failed to validate /home/user/ansible-clickhouse/molecule/ubuntu_xenial/molecule.yml

     ["Additional properties are not allowed ('playbooks' was unexpected)"]
     user@ansible3:/home/user/ansible-clickhouse/$
     ```
  2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

      ```
      user@ansible3:~/Ansible_8.4/playbook/roles/roles_vector$ molecule init scenario --driver-name docker
      INFO     Initializing new scenario default...
      INFO     Initialized scenario in /home/user/Ansible_8.4/playbook/roles/roles_vector/molecule/default successfully.message String ) ENGINE = MergeTree() ORDER BY tuple()'"
      ```
  3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
  4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
     - ```
       - name: Verify
         hosts: all
         gather_facts: false
         tasks:
         - name: Example assertion
           assert:
             that: true
         - name: Check NGINX configs
           shell: vector validate --no-environment --config-yaml /etc/vector/vector.yml
         - name: Check NGINX status
           shell: ps aux | grep [v]ector
       ```
  5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
      ```
        user@ansible3:~/Ansible_8.4/playbook/roles/roles_vector$ molecule test -s centos7
        INFO     centos7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
        INFO     Performing prerun...
        INFO     Guessed /home/user/Ansible_8.4/playbook/roles/roles_vector as project root directory
        INFO     Using /home/user/.cache/ansible-lint/d5239f/roles/user.roles_vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
        INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/home/user/.cache/ansible-lint/d5239f/roles
        INFO     Running centos7 > dependency
        WARNING  Skipping, missing the requirements file.
        WARNING  Skipping, missing the requirements file.
        INFO     Running centos7 > lint
        INFO     Lint is disabled.
        INFO     Running centos7 > cleanup
        WARNING  Skipping, cleanup playbook not configured.
        INFO     Running centos7 > destroy
        INFO     Sanity checks: 'docker'

        PLAY [Destroy] *****************************************************************

        TASK [Destroy molecule instance(s)] ********************************************
        changed: [localhost] => (item=instance)

        TASK [Wait for instance(s) deletion to complete] *******************************
        ok: [localhost] => (item=instance)

        TASK [Delete docker networks(s)] ***********************************************

        PLAY RECAP *********************************************************************
        localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

        INFO     Running centos7 > syntax

        playbook: /home/user/Ansible_8.4/playbook/roles/roles_vector/molecule/centos7/converge.yml
        INFO     Running centos7 > create

        PLAY [Create] ******************************************************************

        TASK [Log into a Docker registry] **********************************************
        skipping: [localhost] => (item=None) 
        skipping: [localhost]

        TASK [Check presence of custom Dockerfiles] ************************************
        ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

        TASK [Create Dockerfiles from image names] *************************************
        skipping: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

        TASK [Discover local Docker images] ********************************************
        ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

        TASK [Build an Ansible compatible image (new)] *********************************
        skipping: [localhost] => (item=molecule_local/centos7) 

        TASK [Create docker network(s)] ************************************************

        TASK [Determine the CMD directives] ********************************************
        ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

        TASK [Create molecule instance(s)] *********************************************
        changed: [localhost] => (item=instance)

        TASK [Wait for instance(s) creation to complete] *******************************
        FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
        changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '498803258345.165895', 'results_file': '/home/user/.ansible_async/498803258345.165895', 'changed': True, 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

        PLAY RECAP *********************************************************************
        localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

        INFO     Running centos7 > prepare
        WARNING  Skipping, prepare playbook not configured.
        INFO     Running centos7 > converge

        PLAY [Converge] ****************************************************************

        TASK [Gathering Facts] *********************************************************
        ok: [instance]

        TASK [Include roles_vector] ****************************************************

        TASK [roles_vector : Install vector] *******************************************
        skipping: [instance]

        TASK [roles_vector : Install vector] *******************************************
        included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

        TASK [roles_vector : VECTOR | Install rpm] *************************************
        changed: [instance]

        TASK [roles_vector : VECTOR | Template config] *********************************
        changed: [instance]

        TASK [roles_vector : Put docker package on hold] *******************************
        ok: [instance]

        PLAY RECAP *********************************************************************
        instance                   : ok=5    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

        INFO     Running centos7 > idempotence

        PLAY [Converge] ****************************************************************

        TASK [Gathering Facts] *********************************************************
        ok: [instance]

        TASK [Include roles_vector] ****************************************************

        TASK [roles_vector : Install vector] *******************************************
        skipping: [instance]

        TASK [roles_vector : Install vector] *******************************************
        included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

        TASK [roles_vector : VECTOR | Install rpm] *************************************
        ok: [instance]

        TASK [roles_vector : VECTOR | Template config] *********************************
        ok: [instance]

        TASK [roles_vector : Put docker package on hold] *******************************
        ok: [instance]

        PLAY RECAP *********************************************************************
        instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

        INFO     Idempotence completed successfully.
        INFO     Running centos7 > side_effect
        WARNING  Skipping, side effect playbook not configured.
        INFO     Running centos7 > verify
        INFO     Running Ansible Verifier

        PLAY [Verify] ******************************************************************

        TASK [Example assertion] *******************************************************
        ok: [instance] => {
            "changed": false,
            "msg": "All assertions passed"
        }

        TASK [Check NGINX configs] *****************************************************
        changed: [instance]

        TASK [Check NGINX status] ******************************************************
        changed: [instance]

        PLAY RECAP *********************************************************************
        instance                   : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

        INFO     Verifier completed successfully.
        INFO     Running centos7 > cleanup
        WARNING  Skipping, cleanup playbook not configured.
        INFO     Running centos7 > destroy

        PLAY [Destroy] *****************************************************************

        TASK [Destroy molecule instance(s)] ********************************************
        changed: [localhost] => (item=instance)

        TASK [Wait for instance(s) deletion to complete] *******************************
        FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
        changed: [localhost] => (item=instance)

        TASK [Delete docker networks(s)] ***********************************************

        PLAY RECAP *********************************************************************
        localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
       ```
  5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
     - https://github.com/ADNikulin/ansible-vector-role/tree/1.0.7

</details>

## Tox
<details>
  <summary>Детали</summary>

  1. Добавьте в директорию с vector-role файлы из [директории](./example).
  2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
  3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
      ```
      user@ansible3:~/Ansible_8.4/playbook/roles/roles_vector$ sudo tox -r
      py38-ansible210 recreate: /home/user/Ansible_8.4/playbook/roles/roles_vector/.tox/py38-ansible210
      py38-ansible210 installdeps: -rtox-requirements.txt, ansible<2.12
      py38-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==2.0.4,ansible-lint==5.1.3,arrow==1.2.2,bcrypt==3.2.2,binaryornot==0.4.4,bracex==2.2.1,Cerberus==1.3.2,certifi==2021.10.8,cffi==1.15.0,chardet==4.0.0,charset-normalizer==2.0.12,click==8.1.3,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==1.7.3,cryptography==37.0.2,distro==1.7.0,docker==5.0.3,enrich==1.2.7,idna==3.3,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.0,lxml==4.8.0,MarkupSafe==2.1.1,molecule==3.4.0,molecule-docker==1.1.0,packaging==21.3,paramiko==2.11.0,pathspec==0.9.0,pluggy==0.13.1,poyo==0.5.0,pycparser==2.21,Pygments==2.12.0,PyNaCl==1.5.0,pyparsing==3.0.9,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==6.0,requests==2.27.1,rich==12.4.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.6,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.0.1,text-unidecode==1.3,typing-extensions==4.2.0,urllib3==1.26.9,wcmatch==8.3,websocket-client==1.3.2,yamllint==1.26.3
      py38-ansible210 run-test-pre: PYTHONHASHSEED='2652192206'
      py38-ansible210 run-test: commands[0] | molecule test -s centos7 --destroy always
      INFO     centos7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
      INFO     Performing prerun...
      WARNING  Failed to guess project directory using git: 
      INFO     Guessed /home/user/Ansible_8.4/playbook/roles/roles_vector as project root directory
      INFO     Using /root/.cache/ansible-lint/d5239f/roles/user.roles_vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
      INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/d5239f/roles
      INFO     Running centos7 > dependency
      WARNING  Skipping, missing the requirements file.
      WARNING  Skipping, missing the requirements file.
      INFO     Running centos7 > lint
      INFO     Lint is disabled.
      INFO     Running centos7 > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7 > destroy
      INFO     Sanity checks: 'docker'

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      ok: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Running centos7 > syntax

      playbook: /home/user/Ansible_8.4/playbook/roles/roles_vector/molecule/centos7/converge.yml
      INFO     Running centos7 > create

      PLAY [Create] ******************************************************************

      TASK [Log into a Docker registry] **********************************************
      skipping: [localhost] => (item=None) 
      skipping: [localhost]

      TASK [Check presence of custom Dockerfiles] ************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create Dockerfiles from image names] *************************************
      skipping: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Discover local Docker images] ********************************************
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

      TASK [Build an Ansible compatible image (new)] *********************************
      skipping: [localhost] => (item=molecule_local/centos7) 

      TASK [Create docker network(s)] ************************************************

      TASK [Determine the CMD directives] ********************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create molecule instance(s)] *********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) creation to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
      FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
      changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '144349367427.38509', 'results_file': '/root/.ansible_async/144349367427.38509', 'changed': True, 'failed': False, 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

      PLAY RECAP *********************************************************************
      localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

      INFO     Running centos7 > prepare
      WARNING  Skipping, prepare playbook not configured.
      INFO     Running centos7 > converge

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      changed: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      changed: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Running centos7 > idempotence

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      ok: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      ok: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Idempotence completed successfully.
      INFO     Running centos7 > side_effect
      WARNING  Skipping, side effect playbook not configured.
      INFO     Running centos7 > verify
      INFO     Running Ansible Verifier

      PLAY [Verify] ******************************************************************

      TASK [Example assertion] *******************************************************
      ok: [instance] => {
          "changed": false,
          "msg": "All assertions passed"
      }

      TASK [Check NGINX configs] *****************************************************
      changed: [instance]

      TASK [Check NGINX status] ******************************************************
      changed: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Verifier completed successfully.
      INFO     Running centos7 > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7 > destroy

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      changed: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Pruning extra files from scenario ephemeral directory
      py38-ansible30 recreate: /home/user/Ansible_8.4/playbook/roles/roles_vector/.tox/py38-ansible30
      py38-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
      py38-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==2.0.4,ansible-lint==5.1.3,arrow==1.2.2,bcrypt==3.2.2,binaryornot==0.4.4,bracex==2.2.1,Cerberus==1.3.2,certifi==2021.10.8,cffi==1.15.0,chardet==4.0.0,charset-normalizer==2.0.12,click==8.1.3,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==1.7.3,cryptography==37.0.2,distro==1.7.0,docker==5.0.3,enrich==1.2.7,idna==3.3,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.0,lxml==4.8.0,MarkupSafe==2.1.1,molecule==3.4.0,molecule-docker==1.1.0,packaging==21.3,paramiko==2.11.0,pathspec==0.9.0,pluggy==0.13.1,poyo==0.5.0,pycparser==2.21,Pygments==2.12.0,PyNaCl==1.5.0,pyparsing==3.0.9,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==6.0,requests==2.27.1,rich==12.4.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.6,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.0.1,text-unidecode==1.3,typing-extensions==4.2.0,urllib3==1.26.9,wcmatch==8.3,websocket-client==1.3.2,yamllint==1.26.3
      py38-ansible30 run-test-pre: PYTHONHASHSEED='2652192206'
      py38-ansible30 run-test: commands[0] | molecule test -s centos7 --destroy always
      INFO     centos7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
      INFO     Performing prerun...
      WARNING  Failed to guess project directory using git: 
      INFO     Guessed /home/user/Ansible_8.4/playbook/roles/roles_vector as project root directory
      INFO     Using /root/.cache/ansible-lint/d5239f/roles/user.roles_vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
      INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/d5239f/roles
      INFO     Running centos7 > dependency
      WARNING  Skipping, missing the requirements file.
      WARNING  Skipping, missing the requirements file.
      INFO     Running centos7 > lint
      INFO     Lint is disabled.
      INFO     Running centos7 > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7 > destroy
      INFO     Sanity checks: 'docker'

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      ok: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Running centos7 > syntax

      playbook: /home/user/Ansible_8.4/playbook/roles/roles_vector/molecule/centos7/converge.yml
      INFO     Running centos7 > create

      PLAY [Create] ******************************************************************

      TASK [Log into a Docker registry] **********************************************
      skipping: [localhost] => (item=None) 
      skipping: [localhost]

      TASK [Check presence of custom Dockerfiles] ************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create Dockerfiles from image names] *************************************
      skipping: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True}) 

      TASK [Discover local Docker images] ********************************************
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

      TASK [Build an Ansible compatible image (new)] *********************************
      skipping: [localhost] => (item=molecule_local/centos7) 

      TASK [Create docker network(s)] ************************************************

      TASK [Determine the CMD directives] ********************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create molecule instance(s)] *********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) creation to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
      FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
      changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '635887692201.40985', 'results_file': '/root/.ansible_async/635887692201.40985', 'changed': True, 'failed': False, 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

      PLAY RECAP *********************************************************************
      localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

      INFO     Running centos7 > prepare
      WARNING  Skipping, prepare playbook not configured.
      INFO     Running centos7 > converge

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      changed: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      changed: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Running centos7 > idempotence

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      ok: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      ok: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Idempotence completed successfully.
      INFO     Running centos7 > side_effect
      WARNING  Skipping, side effect playbook not configured.
      INFO     Running centos7 > verify
      INFO     Running Ansible Verifier

      PLAY [Verify] ******************************************************************

      TASK [Example assertion] *******************************************************
      ok: [instance] => {
          "changed": false,
          "msg": "All assertions passed"
      }

      TASK [Check NGINX configs] *****************************************************
      changed: [instance]

      TASK [Check NGINX status] ******************************************************
      changed: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Verifier completed successfully.
      INFO     Running centos7 > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7 > destroy

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      changed: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Pruning extra files from scenario ephemeral directory
      _________________________________________________________________________________________________ summary _________________________________________________________________________________________________
        py38-ansible210: commands succeeded
        py38-ansible30: commands succeeded
        congratulations :)

      ```
  5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
      ```
      user@ansible3:~/Ansible_8.4/playbook/roles/roles_vector$ molecule matrix test
      INFO     Test matrix
      ---                                                                             
      centos7:                                                                        
        - dependency                                                                  
        - lint                                                                        
        - cleanup                                                                     
        - destroy                                                                     
        - syntax                                                                      
        - create                                                                      
        - prepare                                                                     
        - converge                                                                    
        - idempotence                                                                 
        - side_effect                                                                 
        - verify                                                                      
        - cleanup                                                                     
        - destroy                                                                     
      centos7_Lite:                                                                   
        - create                                                                      
        - prepare                                                                     
        - converge                                                                    
        - idempotence                                                                 
        - side_effect                                                                 
        - verify                                                                      
        - cleanup                                                                     
        - destroy 
      ```
  6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
      ```
      [tox]
      minversion = 1.8
      basepython = python3.6
      envlist = py{38}-ansible{210,30}
      skipsdist = true

      [testenv]
      passenv = *
      deps =
        -r tox-requirements.txt
        ansible210: ansible<2.12
        ansible30: ansible<3.1
      commands =
        {posargs:molecule test -s centos7_lite --destroy always}
      ```
  8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
      ```
      commands =
        {posargs:molecule test -s centos7_lite --destroy always}
      ```
      ```
      user@ansible3:~/Ansible_8.4/playbook/roles/roles_vector$ sudo tox -r
      [sudo] пароль для user: 
      py38-ansible210 recreate: /home/user/Ansible_8.4/playbook/roles/roles_vector/.tox/py38-ansible210
      py38-ansible210 installdeps: -rtox-requirements.txt, ansible<2.12
      py38-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==2.0.4,ansible-lint==5.1.3,arrow==1.2.2,bcrypt==3.2.2,binaryornot==0.4.4,bracex==2.2.1,Cerberus==1.3.2,certifi==2021.10.8,cffi==1.15.0,chardet==4.0.0,charset-normalizer==2.0.12,click==8.1.3,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==1.7.3,cryptography==37.0.2,distro==1.7.0,docker==5.0.3,enrich==1.2.7,idna==3.3,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.0,lxml==4.8.0,MarkupSafe==2.1.1,molecule==3.4.0,molecule-docker==1.1.0,packaging==21.3,paramiko==2.11.0,pathspec==0.9.0,pluggy==0.13.1,poyo==0.5.0,pycparser==2.21,Pygments==2.12.0,PyNaCl==1.5.0,pyparsing==3.0.9,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==6.0,requests==2.27.1,rich==12.4.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.6,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.0.1,text-unidecode==1.3,typing-extensions==4.2.0,urllib3==1.26.9,wcmatch==8.3,websocket-client==1.3.2,yamllint==1.26.3
      py38-ansible210 run-test-pre: PYTHONHASHSEED='4276288680'
      py38-ansible210 run-test: commands[0] | molecule test -s centos7_lite --destroy always
      INFO     centos7_lite scenario test matrix: create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
      INFO     Performing prerun...
      WARNING  Failed to guess project directory using git: 
      INFO     Guessed /home/user/Ansible_8.4/playbook/roles/roles_vector as project root directory
      INFO     Using /root/.cache/ansible-lint/d5239f/roles/user.roles_vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
      INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/d5239f/roles
      INFO     Running centos7_lite > create
      INFO     Sanity checks: 'docker'

      PLAY [Create] ******************************************************************

      TASK [Log into a Docker registry] **********************************************
      skipping: [localhost] => (item=None) 
      skipping: [localhost]

      TASK [Check presence of custom Dockerfiles] ************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create Dockerfiles from image names] *************************************
      skipping: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Discover local Docker images] ********************************************
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

      TASK [Build an Ansible compatible image (new)] *********************************
      skipping: [localhost] => (item=molecule_local/centos7) 

      TASK [Create docker network(s)] ************************************************

      TASK [Determine the CMD directives] ********************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create molecule instance(s)] *********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) creation to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
      FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
      changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '951430949755.48735', 'results_file': '/root/.ansible_async/951430949755.48735', 'changed': True, 'failed': False, 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

      PLAY RECAP *********************************************************************
      localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

      INFO     Running centos7_lite > prepare
      WARNING  Skipping, prepare playbook not configured.
      INFO     Running centos7_lite > converge

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      changed: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      changed: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Running centos7_lite > idempotence

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      ok: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      ok: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Idempotence completed successfully.
      INFO     Running centos7_lite > side_effect
      WARNING  Skipping, side effect playbook not configured.
      INFO     Running centos7_lite > verify
      INFO     Running Ansible Verifier

      PLAY [Verify] ******************************************************************

      TASK [Example assertion] *******************************************************
      ok: [instance] => {
          "changed": false,
          "msg": "All assertions passed"
      }

      TASK [Check NGINX configs] *****************************************************
      changed: [instance]

      TASK [Check NGINX status] ******************************************************
      changed: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Verifier completed successfully.
      INFO     Running centos7_lite > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7_lite > destroy

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      changed: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Pruning extra files from scenario ephemeral directory
      py38-ansible30 recreate: /home/user/Ansible_8.4/playbook/roles/roles_vector/.tox/py38-ansible30
      py38-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
      py38-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==2.0.4,ansible-lint==5.1.3,arrow==1.2.2,bcrypt==3.2.2,binaryornot==0.4.4,bracex==2.2.1,Cerberus==1.3.2,certifi==2021.10.8,cffi==1.15.0,chardet==4.0.0,charset-normalizer==2.0.12,click==8.1.3,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==1.7.3,cryptography==37.0.2,distro==1.7.0,docker==5.0.3,enrich==1.2.7,idna==3.3,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.0,lxml==4.8.0,MarkupSafe==2.1.1,molecule==3.4.0,molecule-docker==1.1.0,packaging==21.3,paramiko==2.11.0,pathspec==0.9.0,pluggy==0.13.1,poyo==0.5.0,pycparser==2.21,Pygments==2.12.0,PyNaCl==1.5.0,pyparsing==3.0.9,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==6.0,requests==2.27.1,rich==12.4.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.6,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.0.1,text-unidecode==1.3,typing-extensions==4.2.0,urllib3==1.26.9,wcmatch==8.3,websocket-client==1.3.2,yamllint==1.26.3
      py38-ansible30 run-test-pre: PYTHONHASHSEED='4276288680'
      py38-ansible30 run-test: commands[0] | molecule test -s centos7_lite --destroy always
      INFO     centos7_lite scenario test matrix: create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
      INFO     Performing prerun...
      WARNING  Failed to guess project directory using git: 
      INFO     Guessed /home/user/Ansible_8.4/playbook/roles/roles_vector as project root directory
      INFO     Using /root/.cache/ansible-lint/d5239f/roles/user.roles_vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
      INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/d5239f/roles
      INFO     Running centos7_lite > create
      INFO     Sanity checks: 'docker'

      PLAY [Create] ******************************************************************

      TASK [Log into a Docker registry] **********************************************
      skipping: [localhost] => (item=None) 
      skipping: [localhost]

      TASK [Check presence of custom Dockerfiles] ************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create Dockerfiles from image names] *************************************
      skipping: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True}) 

      TASK [Discover local Docker images] ********************************************
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

      TASK [Build an Ansible compatible image (new)] *********************************
      skipping: [localhost] => (item=molecule_local/centos7) 

      TASK [Create docker network(s)] ************************************************

      TASK [Determine the CMD directives] ********************************************
      ok: [localhost] => (item={'image': 'centos7', 'name': 'instance', 'pre_build_image': True})

      TASK [Create molecule instance(s)] *********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) creation to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
      FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
      changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '637561100558.51200', 'results_file': '/root/.ansible_async/637561100558.51200', 'changed': True, 'failed': False, 'item': {'image': 'centos7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

      PLAY RECAP *********************************************************************
      localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

      INFO     Running centos7_lite > prepare
      WARNING  Skipping, prepare playbook not configured.
      INFO     Running centos7_lite > converge

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      changed: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      changed: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Running centos7_lite > idempotence

      PLAY [Converge] ****************************************************************

      TASK [Gathering Facts] *********************************************************
      ok: [instance]

      TASK [Include roles_vector] ****************************************************

      TASK [roles_vector : Install vector] *******************************************
      included: /home/user/Ansible_8.4/playbook/roles/roles_vector/tasks/install_vector_docker.yml for instance

      TASK [roles_vector : VECTOR | Install rpm] *************************************
      ok: [instance]

      TASK [roles_vector : VECTOR | Template config] *********************************
      [WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
      this does not look like what you expect, quote the entire value to ensure it
      does not change.
      ok: [instance]

      TASK [roles_vector : Put docker package on hold] *******************************
      ok: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Idempotence completed successfully.
      INFO     Running centos7_lite > side_effect
      WARNING  Skipping, side effect playbook not configured.
      INFO     Running centos7_lite > verify
      INFO     Running Ansible Verifier

      PLAY [Verify] ******************************************************************

      TASK [Example assertion] *******************************************************
      ok: [instance] => {
          "changed": false,
          "msg": "All assertions passed"
      }

      TASK [Check NGINX configs] *****************************************************
      changed: [instance]

      TASK [Check NGINX status] ******************************************************
      changed: [instance]

      PLAY RECAP *********************************************************************
      instance                   : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

      INFO     Verifier completed successfully.
      INFO     Running centos7_lite > cleanup
      WARNING  Skipping, cleanup playbook not configured.
      INFO     Running centos7_lite > destroy

      PLAY [Destroy] *****************************************************************

      TASK [Destroy molecule instance(s)] ********************************************
      changed: [localhost] => (item=instance)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      changed: [localhost] => (item=instance)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Pruning extra files from scenario ephemeral directory
      _________________________________________________________________________________________________ summary _________________________________________________________________________________________________
        py38-ansible210: commands succeeded
        py38-ansible30: commands succeeded
        congratulations :)
      ```
  9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
     - https://github.com/ADNikulin/ansible-vector-role/tree/1.0.8

</details>

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.