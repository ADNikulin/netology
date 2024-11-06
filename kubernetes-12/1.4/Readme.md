# Kubernetes. Никулин Александр. 
# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить доступ к приложению, установленному в предыдущем ДЗ и состоящему из двух контейнеров, по разным портам в разные контейнеры как внутри кластера, так и снаружи.

------

### Чеклист готовности к домашнему заданию
<details>
  <summary>Детали</summary>

  1. Установленное k8s-решение (например, MicroK8S).
  2. Установленный локальный kubectl.
  3. Редактор YAML-файлов с подключённым Git-репозиторием.
</details>

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Описание Service.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера
<details>
  <summary>Детали</summary>

  1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
      > [Манифест](nginx.deployment.yaml) \
      > ![alt text](images/image100.png) \
      > ![alt text](images/image99.png)
  2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.
      > [Манифест](nginx.svc.yaml) \
      > ![alt text](images/image89.png)
  3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.
      > [Манифест](multitool.pod.yaml) \
      > ![alt text](images/image88.png) \
      > по портам запросы чуть ниже
  4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
      > ![alt text](images/image87.png) \
      > ![alt text](images/image88.png) \
      > ![alt text](images/image86.png) \
      > ![alt text](images/image85.png)
  5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.
      > Ход выполнения задания представлен выше
</details>
------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера
<details>
  <summary>Детали</summary>

  1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.
      > Создал отдельный деплоймент, что бы понабивать руки \
      > [Деплоймент](nginx-node.deployment.yaml) \
      > [Service](nginx-node,.svc.yaml) \
      > ![alt text](images/image83.png)
  2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
      > Делал всё на этой машине \
      > ![alt text](images/image79.png) \
      > ![alt text](images/image80.png) \
      > ![alt text](images/image81.png) \
      > ![alt text](images/image82.png)
  3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.
      > Ход выполнения задания представлен выше
</details>
------