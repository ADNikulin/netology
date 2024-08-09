# Система управления конфигурациями. Никулин Александр. 
# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

<details>
  <summary>Детали</summary>

  1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
  2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
  3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
  4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

</details>

## Основная часть

<details>
  <summary>Детали</summary>

  1. Подготовьте свой inventory-файл `prod.yml`.
     - ![image](https://github.com/user-attachments/assets/b7426e13-c7f7-4241-9886-aee2d8caa382)
     - ![image](https://github.com/user-attachments/assets/2d631793-5b31-4f47-9474-f635d0c4db2e)

  2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!
     >
  3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
     >
  4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
     > 
  5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
     - ![image](https://github.com/user-attachments/assets/cfffb1a4-15a6-4726-ac11-bf19daf10a8a)
     - Был один касяк - ![image](https://github.com/user-attachments/assets/78714726-5e2c-4f0c-9d20-b2b3d2deb87e)
     - исправил

  6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
     - ![image](https://github.com/user-attachments/assets/63571464-c7fa-4941-a6b7-f8f2eeadf426)
     - ПО рецептам выше доработал плейбук и потом запустил в режиме чек. По итогу падал на попытке расспоковать файлы по началу. ну оно и понятно, так как в режиме проверки делаем. 
     - Далее запуск был с прерванным плейбуком, результаты на картинке
     - ![image](https://github.com/user-attachments/assets/c3cc23e3-d297-420f-b22a-0e61a6263ca7)
     - ![image](https://github.com/user-attachments/assets/fc48a1dc-3ac3-431e-b616-92d7e4c2dc5f)

  7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
     - запустил
     - ![image](https://github.com/user-attachments/assets/c9184167-2931-4fb4-9312-94677ef996d6)
     - ![image](https://github.com/user-attachments/assets/30434e0f-516b-4d52-936f-246fb7688b28)
     - ![image](https://github.com/user-attachments/assets/2cfefe1c-faea-4141-9bf3-6848bbefe2af)

  8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
     - ![image](https://github.com/user-attachments/assets/c27b03ed-e253-42bf-a4de-b863d83fabc0)
     - ![image](https://github.com/user-attachments/assets/82263dd1-340b-4b6c-81a8-09f900553264)
     - ![image](https://github.com/user-attachments/assets/e75b6136-7a69-4b46-8ba7-26a6d71c5b46)
     
  10. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8
      - ну так, просто накидал вторйо ридми2, особо париться в наполнение не стал
      - https://github.com/ADNikulin/netology/blob/master/ansible-08/02-playbook/README2.md
  12. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.
      - ![image](https://github.com/user-attachments/assets/3df48a41-6ba5-44d5-bfc6-f967462ede2a)
      - https://github.com/ADNikulin/netology/tree/08-ansible-02-playbook/ansible-08/02-playbook

</details>
