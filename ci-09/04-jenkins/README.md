# Непрерывная разработка и интеграция. Никулин Александр. 
# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению
<details>
  <summary>Детали</summary>

  1. Создать два VM: для jenkins-master и jenkins-agent.
      - ![alt text](imgs/image100.png)
  2. Установить Jenkins при помощи playbook.
      - ![alt text](imgs/image99.png)
      - ![alt text](imgs/image98.png)
  3. Запустить и проверить работоспособность.
      - ![alt text](imgs/image97.png)
  4. Сделать первоначальную настройку.
      - ![alt text](imgs/image96.png)
      - ![alt text](imgs/image95.png)
      - ![alt text](imgs/image94.png)
      - ![alt text](imgs/image93.png)
</details>

## Основная часть
<details>
  <summary>Детали</summary>
  
  1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
  2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
  3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
  4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
  5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
  6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
  7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
  8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
  9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!
</details>

## Необязательная часть

<details>
  <summary>Детали</summary>

  1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
  2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.
</details>
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
