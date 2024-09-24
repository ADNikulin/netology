# Непрерывная разработка и интеграция. Никулин Александр. 
# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

<details>
  <summary>Детали</summary>

  1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
      - ![alt text](imgs/image100.png)
      - ![alt text](imgs/image99.png)
  2. Дождитесь запуска teamcity, выполните первоначальную настройку.
      - ![alt text](imgs/image98.png)
      - ![alt text](imgs/image97.png)
      - ![alt text](imgs/image96.png)
      - ![alt text](imgs/image95.png)
  3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
      - ![alt text](imgs/image94.png)
      - ![alt text](imgs/image93.png)
      - ![alt text](imgs/image92.png)
  4. Авторизуйте агент.
      - ![alt text](imgs/image91.png)
      - ![alt text](imgs/image90.png)
  5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).
      - https://github.com/ADNikulin/example-teamcity
  6. Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure).
      - ![alt text](imgs/image89.png)
      - ![alt text](imgs/image88.png)
</details>

## Основная часть

<details>
  <summary>Детали</summary>

  1. Создайте новый проект в teamcity на основе fork.
      - ![alt text](imgs/image87.png)
  2. Сделайте autodetect конфигурации.
      - ![alt text](imgs/image86.png)
  3. Сохраните необходимые шаги, запустите первую сборку master.
      - ![alt text](imgs/image85.png)
      - ![alt text](imgs/image84.png)
      - ![alt text](imgs/image83.png)
  4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.
      - ![alt text](imgs/image82.png)
  5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, 
  предварительно записав туда креды для подключения к nexus.
      - ![alt text](imgs/image81.png)
  6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
      - ![alt text](imgs/image80.png)
  7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.
      - ![alt text](imgs/image79.png)
      - ![alt text](imgs/image78.png)
      - ![alt text](imgs/image77.png)
  8. Мигрируйте `build configuration` в репозиторий.
      - ![alt text](imgs/image76.png)
      - https://github.com/ADNikulin/example-teamcity/tree/master/.teamcity/Example
  9. Создайте отдельную ветку `feature/add_reply` в репозитории.
      - ![alt text](imgs/image74.png)
  10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
      - https://github.com/ADNikulin/example-teamcity/blob/feature/add_reply/src/main/java/plaindoll/Welcomer.java
      - ![alt text](imgs/image75.png)
  11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
      - https://github.com/ADNikulin/example-teamcity/blob/feature/add_reply/src/test/java/plaindoll/WelcomerTest.java
      - ![alt text](imgs/image73.png)
  12. Сделайте push всех изменений в новую ветку репозитория.
      - ![alt text](imgs/image72.png)
  13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
      - ![alt text](imgs/image71.png)
      - ![alt text](imgs/image70.png)
      - ![alt text](imgs/image69.png)
  14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
      - ![alt text](imgs/image68.png)
      - ![alt text](imgs/image67.png)
      - https://github.com/ADNikulin/example-teamcity/pull/1
  15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
      - ![alt text](imgs/image66.png)
  16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
      - ![alt text](imgs/image65.png)
  17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
      - ![alt text](imgs/image64.png)
      - ![alt text](imgs/image63.png)
  18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
      - https://github.com/ADNikulin/example-teamcity/commit/e27732d11d4b61f0a6e606777dd89fc3039cd8d8
  19. В ответе пришлите ссылку на репозиторий.
      - https://github.com/ADNikulin/example-teamcity

</details>
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
