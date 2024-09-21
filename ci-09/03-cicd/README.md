# Непрерывная разработка и интеграция. Никулин Александр. 
# Домашнее задание к занятию «Жизненный цикл ПО»

## Подготовка к выполнению

<details>
  <summary>Детали</summary>

  1. Получить бесплатную версию Jira - https://www.atlassian.com/ru/software/jira/work-management/free (скопируйте ссылку в адресную строку). Вы можете воспользоваться любым(в том числе бесплатным vpn сервисом) если сайт у вас недоступен. Кроме того вы можете скачать [docker образ](https://hub.docker.com/r/atlassian/jira-software/#) и запустить на своем хосте self-managed версию jira.
  2. Настроить её для своей команды разработки.
  3. Создать доски Kanban и Scrum.
  4. [Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).

</details>

## Основная часть

> Зарегался во фри версии и подготовил две доски, скрам и канбан
> ![image](https://github.com/user-attachments/assets/8ec702a1-a1bd-4c75-9e56-137de66381a4)

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

- Переходим к созданию ворк флоу:
- ![image](https://github.com/user-attachments/assets/f832aa3c-e4e3-4935-9672-474562ca6472)
- ![image](https://github.com/user-attachments/assets/94535488-cd51-4651-9050-37ccaf5b2a0f)
- ![image](https://github.com/user-attachments/assets/41183476-1b9c-4c59-955f-db321c6f3082)
- ![image](https://github.com/user-attachments/assets/273d285e-4e1a-43af-98e9-1948bb0e8403)
- ворк флоу готовы, делаем назначения
- ![image](https://github.com/user-attachments/assets/b6fadf67-4422-4e03-abef-b28d1db2002c)


**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done.
   - для начала ассоциирцуем статусы с нужными столбцами
   - ![image](https://github.com/user-attachments/assets/8b05252e-a329-4d24-9a46-f651704466f6)
   - завел две задачи:
   - ![image](https://github.com/user-attachments/assets/7cb27ea7-1d27-4ad3-9260-40da917fed7d)
   - провел по статусам баг:
   - ![image](https://github.com/user-attachments/assets/197ae424-b3f4-4882-aa79-3ca65cc88ecb)
   - ![image](https://github.com/user-attachments/assets/8bf590da-9a8f-4833-ae17-81adb71c8034)
   - ну можно и перетащить его так: 
   - ![image](https://github.com/user-attachments/assets/41100d90-7e93-476b-8bdc-778caaf821d2)
   - ![image](https://github.com/user-attachments/assets/7cf05699-c2bc-454d-b36e-87c960477465)
   - ![image](https://github.com/user-attachments/assets/02ca0b1c-ba4f-4cfd-8fc2-b37c65c24ade)
   - ![image](https://github.com/user-attachments/assets/d43c7545-124d-452c-a411-b52fb489391e)
   - ![image](https://github.com/user-attachments/assets/64442cfe-8911-43e7-a4d9-2558d360c9b8)
   - ![image](https://github.com/user-attachments/assets/f8457a0b-3456-44bc-8c6a-fc24e417bd32)
   - ![image](https://github.com/user-attachments/assets/dd0f3de7-3d52-4c83-bbe7-ed201169ebab)
   - ![image](https://github.com/user-attachments/assets/f77728e5-5b39-4f0f-a741-f2e642e53c4f)
   - ![image](https://github.com/user-attachments/assets/d00890ad-c937-4b58-afd8-4fcfe5b59a4d)
     
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done.
   - ![image](https://github.com/user-attachments/assets/363c41db-3851-48db-8ee0-e858eb2e1a8a)
   - ![image](https://github.com/user-attachments/assets/bf7952d1-0743-48b5-8224-6a3674945875)
   - ![image](https://github.com/user-attachments/assets/76a3f551-8a9a-4c17-a33f-72de62798861)
   - ![image](https://github.com/user-attachments/assets/c83a3c50-812e-41f1-94c7-363552638a4e)
   - ![image](https://github.com/user-attachments/assets/c0795f02-eecf-45d1-a919-5bfbeb8b1da5)
   - ![image](https://github.com/user-attachments/assets/14740b5a-00f9-4111-95d1-ee368ba00b7d)

1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
   - ![image](https://github.com/user-attachments/assets/5181078c-b109-44b7-b0d6-cbf6eab6f1ab)
   - ![image](https://github.com/user-attachments/assets/7044d7a7-830c-4b6d-9835-693c935c08b2)

1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
   - создал скрам доску на базе скрама
   - ![image](https://github.com/user-attachments/assets/11999bfa-1d49-47a9-9d10-1865b39bc4cf)
   - создаем спринт
   - ![image](https://github.com/user-attachments/assets/326ffe12-7219-42ec-90a8-5aed9c3bd6b2)
   - Аналагично настраиваем ассоциацию статусов со столбцами
   - ![image](https://github.com/user-attachments/assets/27e374da-398f-40b1-9c03-a9226b9cfbea)
   - наполняем спринт и запускаем
   - ![image](https://github.com/user-attachments/assets/9923a7f8-df67-4cca-a78e-68d5ba6e033a)
   - ![image](https://github.com/user-attachments/assets/9310d100-c2c9-444b-bcae-afa1a24f7cf0)
   - Все теже телодвижения
   - ![image](https://github.com/user-attachments/assets/0bc5bdd8-a959-49a2-b286-12f36343fae5)
   - ![image](https://github.com/user-attachments/assets/1f8e1b5a-27d7-4545-a6f6-b931e603d9aa)
   - ![image](https://github.com/user-attachments/assets/5a6ea371-9006-4dee-bd4f-52d186df3237)
   - только тут убрал один столбец, точнее он несколько включает в себя статусов, но можно докинуть столбец с закрыто, либо вообще исключить стату из спринтового отображения.
   - всё сделал короче и закрываю спринт.
   - ![image](https://github.com/user-attachments/assets/c608aed2-cdd1-4953-8ce6-f620c3b4baf2)
   - ![image](https://github.com/user-attachments/assets/c901c84d-f23d-4ace-8c28-30e16fc03c25)
   - автоматом предлагает создать новый, на основе старого

3. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.
  - [bugs work flow](<BUG Workflow.xml>)
  - [common work flow](<common workflow.xml>)

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
