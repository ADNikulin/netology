# Система управления конфигурациями. Никулин Александр. 
# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению
<details>
  <summary>Детали</summary>

  1. Установите Ansible версии 2.10 или выше.
  2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
  3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

  > ![image](https://github.com/user-attachments/assets/8e1395cd-a916-436b-854a-59a81430799d) \
  > ![image](https://github.com/user-attachments/assets/88fa196e-0c67-48b8-8e1f-7681a2dd4fb7)

</details>

## Основная часть
<details>
  <summary>Детали</summary>
	
  1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
     > ![image](https://github.com/user-attachments/assets/dd0f590a-dabf-4460-82e5-ff653d489d4d)

  2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
     > ![image](https://github.com/user-attachments/assets/98a2761a-d62e-4ac7-8bec-f1c0bf154318)
  3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
     > ![image](https://github.com/user-attachments/assets/aab047fb-ac36-4c90-bb37-d9e0ca9bd742)
  4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
     > ![image](https://github.com/user-attachments/assets/35aefd3c-a8f1-47bf-a2f8-92891294f539)
  5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default   fact`.
     > ![image](https://github.com/user-attachments/assets/6d452d71-c7de-4e1f-ab97-0bd6ba4a5d59)
  6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
     > ![image](https://github.com/user-attachments/assets/47c30e1b-df36-4201-a0cf-5e7c6978bf0e)
  7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
     > ![image](https://github.com/user-attachments/assets/c764af82-ffc3-45dc-8d1a-ed39e274ceca) \
     > ![image](https://github.com/user-attachments/assets/1e97f190-11d6-4910-8703-b71a43374f82)

  8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
     > ![image](https://github.com/user-attachments/assets/72d3a2ae-1f37-4d17-9dcd-dcb63060e55f)

  9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
     > ![image](https://github.com/user-attachments/assets/94e716d7-ffdf-4392-aadb-a1c38805fa04) \
     > А что сделать надо? **ansible.builtin.ssh** - такой плагин выбрать? 

  10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
      > ![image](https://github.com/user-attachments/assets/6731e991-ca52-4046-bd54-a8364b4bddb1)

  11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
      > ![image](https://github.com/user-attachments/assets/09bf5889-3714-4d9a-8e9c-770500ac43f5)

  12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
      > 
  13. Предоставьте скриншоты результатов запуска команд.
      > скриншоты приложены выше.
</details>

## Необязательная часть

<details>
  <summary>Детали</summary>
	
  1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
     > ![image](https://github.com/user-attachments/assets/95b079a3-d1b9-4a05-a9ee-14e24caab200)
  2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
     >![image](https://github.com/user-attachments/assets/48115679-0b94-4660-b208-ef2ee47ef20b)
  3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
     > ![image](https://github.com/user-attachments/assets/e6f4d6f8-0a3b-441f-9a34-383b6bf70614)
  4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
     > ![image](https://github.com/user-attachments/assets/730b5c45-a3da-48d9-a888-b18be27f639d) \
     > ![image](https://github.com/user-attachments/assets/eecf10d7-975f-472c-a0d1-b43c727c2f87) \
     > ![image](https://github.com/user-attachments/assets/35e6d2dc-09df-4b3b-90ff-ae1a2a03d64f) \
  5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
  6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.
   > ready
	
</details>
---
