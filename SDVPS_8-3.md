# 8.2. CI/CD — Никулин Александр
# Домашнее задание к занятию «GitLab»

---

### Задание 1

**Что нужно сделать:**

1. Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в [этом репозитории](https://github.com/netology-code/sdvps-materials/tree/main/gitlab).   
2. Создайте новый проект и пустой репозиторий в нём.
3. Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

### Решение 1

<details>
  <summary>Скриншоты к решению</summary>

  > Подготовил виртуалку в Яоблаке \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/33007ff7-22dc-4c45-b5e4-dd3d8de78c4c) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/f748a7b8-6e93-4a78-8bd8-24475d6d3408) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/3c64e7e3-834e-43c3-bea6-db368ecd2eee) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/d9f6f2c4-44e2-4b9e-8c76-b063fb0e74c2) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/765a579e-39d9-4094-bc1e-ab93cd4e7d07) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/eb7d9ce3-d9a5-478c-a550-fa164f8246dd)
</details>

---

### Задание 2

**Что нужно сделать:**

1. Запушьте [репозиторий](https://github.com/netology-code/sdvps-materials/tree/main/gitlab) на GitLab, изменив origin. Это изучалось на занятии по Git.
2. Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте: 
   
 * файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне; 
 * скриншоты с успешно собранными сборками.

### Решение 2

<details>
  <summary>Скриншоты к решению</summary>

  > ![image](https://github.com/ADNikulin/netology/assets/44374132/29cdd717-5ca2-4288-9991-65c370c1808d) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/f0ba36f3-dddb-424b-b560-3ae3b172ed32) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/ea95c120-0395-4a06-83fb-4b6597aa8b14) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/3f571326-2a5c-495c-a70f-d5e3db1f958c)
</details>
 
---
## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 3*

Измените CI так, чтобы:

 - этап сборки запускался сразу, не дожидаясь результатов тестов;
 - тесты запускались только при изменении файлов с расширением *.go.

В качестве ответа добавьте в шаблон с решением файл gitlab-ci.yml своего проекта или вставьте код в соответсвующее поле в шаблоне.

### Решение 3*

<details>
  <summary>Скриншоты к решению</summary>

  > Сам файл
  ```yaml
    stages:
    - test
    - build
  
  test:
    stage: test
    image: golang:1.17
    script:
      - go test .
    only:
      changes: 
        - "*.go"
  
  build:
    stage: build
    needs: []
    image: docker:latest
    script:
      - docker build .
  ```

  > Конфиг в проекте: \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/979e9d03-9d2e-44d4-a083-58b89b3eb0a7)
  > "Паралельная" сборка \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/6328f354-70e8-45a2-a0eb-ab8dc1dbd667) \
  > Без теста \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/e656ea09-2ed5-466b-a7e0-90a2e0b503be) \
  > Последовательная \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/325bd54d-1011-4927-8bb4-ab009f734509)
</details>
 
