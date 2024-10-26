# Kubernetes. Никулин Александр. 
# Домашнее задание к занятию «Базовые объекты K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера. 

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.
<details>
  <summary>Результат</summary>

  > ![alt text](imgs/image100.png) \
  > ![alt text](imgs/image95.png)
</details>

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов.
2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/).

------

### Задание 1. Создать Pod с именем hello-world

<details>
  <summary>Детали</summary>

  1. Создать манифест (yaml-конфигурацию) Pod.
      > ![alt text](imgs/image97.png)
  2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
      > ![alt text](imgs/image97.png)
  3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).
      > ![alt text](imgs/image98.png) \
      > ![alt text](imgs/image99.png)
</details>
------

### Задание 2. Создать Service и подключить его к Pod

<details>
  <summary>Детали</summary>

  1. Создать Pod с именем netology-web.
      > ![alt text](imgs/image90.png)
  2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
      > ![alt text](imgs/image90.png)
  3. Создать Service с именем netology-svc и подключить к netology-web.
      > ![alt text](imgs/image89.png)
  4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).
      > ![alt text](imgs/image88.png) \
      > ![alt text](imgs/image87.png)
</details>
------
