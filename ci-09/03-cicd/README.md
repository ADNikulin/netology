# Непрерывная разработка и интеграция. Никулин Александр. 
# Домашнее задание к занятию 9 «Процессы CI/CD»

## Подготовка к выполнению

<details>
  <summary>Детали</summary>

  1. Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям).
      - ![alt text](imgs/image100.png)
  2. Пропишите в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook](./infrastructure/site.yml) созданные хосты.
      - ![alt text](imgs/image99.png)
  3. Добавьте в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё.
      - ![alt text](imgs/image97.png)
  4. Запустите playbook, ожидайте успешного завершения.
      - пришлось править так же реcentosBase repo на vault и накатывать 12й постгрю
      - ![alt text](imgs/image96.png)
  5. Проверьте готовность SonarQube через [браузер](http://localhost:9000).
      - ![alt text](imgs/image94.png)
  6. Зайдите под admin\admin, поменяйте пароль на свой.
      - ![alt text](imgs/image95.png)
  7.  Проверьте готовность Nexus через [бразуер](http://localhost:8081).
      - ![alt text](imgs/image93.png)
  8. Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ.
      - ![alt text](imgs/image92.png)

</details>

## Знакомоство с SonarQube

### Основная часть

<details>
  <summary>Детали</summary>

  1. Создайте новый проект, название произвольное.
      - ![alt text](imgs/image91.png)
  2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
      - ![alt text](imgs/image90.png)
      - ![alt text](imgs/image89.png)
  3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
      - ![alt text](imgs/image88.png)
  4. Проверьте `sonar-scanner --version`.
      - ![alt text](imgs/image88.png)
  5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.
      - ![alt text](imgs/image87.png)
      - ![alt text](imgs/image86.png)
  6. Посмотрите результат в интерфейсе.
      - ![alt text](imgs/image85.png)
  7. Исправьте ошибки, которые он выявил, включая warnings.
      - ![alt text](imgs/image84.png)
  8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.
      - ![alt text](imgs/image83.png)
  9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.
      - ![alt text](imgs/image82.png)

</details>

## Знакомство с Nexus

### Основная часть

<details>
  <summary>Детали</summary>

  1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:

  *    groupId: netology;
  *    artifactId: java;
  *    version: 8_282;
  *    classifier: distrib;
  *    type: tar.gz.
    
  2. В него же загрузите такой же артефакт, но с version: 8_102.
  3. Проверьте, что все файлы загрузились успешно.
  4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.

</details>

### Знакомство с Maven

### Подготовка к выполнению

<details>
  <summary>Детали</summary>
  1. Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi).
  2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
  3. Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.
  4. Проверьте `mvn --version`.
  5. Заберите директорию [mvn](./mvn) с pom.

  ### Основная часть

  1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
  2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.
  3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.
  4. В ответе пришлите исправленный файл `pom.xml`.

</details>

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
