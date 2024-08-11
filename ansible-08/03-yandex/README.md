# Система управления конфигурациями. Никулин Александр. 
# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению
<details>
  <summary>Детали</summary>

  1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
     - ![image](https://github.com/user-attachments/assets/91298dbd-4dfc-4ce8-9239-a3c556a73efe)
  2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).
     - ![image](https://github.com/user-attachments/assets/2516f5e7-da27-4352-a3b9-520462375256)

</details>

## Основная часть
<details>
  <summary>Детали</summary>

  1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
     - ![image](https://github.com/user-attachments/assets/2496a726-9434-4a16-a6f3-aaa0129ac0d1)
  2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
     - ![image](https://github.com/user-attachments/assets/22006b0e-c85e-4e70-94e7-aaca9bffdba6)
     - ![image](https://github.com/user-attachments/assets/a71d390b-405c-4815-b03d-6cac596f85be)
  3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
     - ![image](https://github.com/user-attachments/assets/aaad6852-f956-49df-83e3-26775bc497d7)
     - ![image](https://github.com/user-attachments/assets/151bf2e0-b31a-4683-81a8-e903e2f6f021)
     - ![image](https://github.com/user-attachments/assets/519d41a0-5d8c-482a-b71f-5fecf0cc1c9f)
  4. Подготовьте свой inventory-файл `prod.yml`.
     - ![image](https://github.com/user-attachments/assets/4eb41cad-d65c-46dd-9c53-ab3c04d6e3d1)
  5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
     - ![image](https://github.com/user-attachments/assets/e86bd495-4bc2-4bd4-9112-a3364eb1dacb)
  6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
     - ![image](https://github.com/user-attachments/assets/276a7881-d861-426c-8997-f8efa0301ae5)
     - ![image](https://github.com/user-attachments/assets/af1776ea-1965-40c9-8d1d-6976e3af0377)
  7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
     - ![image](https://github.com/user-attachments/assets/bc81380e-07e1-4112-81cb-91c72b82150d)
     - ![image](https://github.com/user-attachments/assets/37eeb6c0-5b01-42c6-a7cd-721dbb1b82eb)
  8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
     - ![image](https://github.com/user-attachments/assets/e8eaebde-e95c-4c22-9de5-934ab13bce32)
  9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
     - Ну так, просто накидал второй ридми2, особо париться в наполнение не стал.
     - https://github.com/ADNikulin/netology/blob/master/ansible-08/03-yandex/README2.md
  10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.
      - https://github.com/ADNikulin/netology/tree/08-ansible-03-yandex/ansible-08/03-yandex
  
</details>
---
