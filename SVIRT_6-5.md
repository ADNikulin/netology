# 6.5. Виртуализация — Никулин Александр
# Домашнее задание к занятию «Kubernetes. Часть 1»

---

### Задание 1

**Выполните действия:**

1. Запустите Kubernetes локально, используя k3s или minikube на свой выбор.
1. Добейтесь стабильной работы всех системных контейнеров.
2. В качестве ответа пришлите скриншот результата выполнения команды kubectl get po -n kube-system.

### Решение 1

> Установка \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/415461a8-a4b5-4cbc-9819-bb189331a1f9) \
> Проверка \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/6c3fca7c-d7d8-4cd9-96e4-ce50f2270e5f) \


------
### Задание 2


Есть файл с деплоем:

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis
        env:
         - name: REDIS_PASSWORD
           value: password123
        ports:
        - containerPort: 6379
```

------
**Выполните действия:**

1. Измените файл с учётом условий:

 * redis должен запускаться без пароля;
 * создайте Service, который будет направлять трафик на этот Deployment;
 * версия образа redis должна быть зафиксирована на 6.0.13.

2. Запустите Deployment в своём кластере и добейтесь его стабильной работы.
3. В качестве решения пришлите получившийся файл.

### Решение 2
> Сервисы \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/23f4c048-d3eb-4908-87df-ac4da8fb7bea) \
> Конфиги Deployment \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/f1ea3337-1971-4b0c-a550-002c89d88222) \
> Конфиги Service \
> ![image](https://github.com/ADNikulin/netology/assets/44374132/9ab1bb78-b571-4922-b400-c20766c2d005) \

------
### Задание 3

**Выполните действия:**

1. Напишите команды kubectl для контейнера из предыдущего задания:

 - выполнения команды ps aux внутри контейнера;
 - просмотра логов контейнера за последние 5 минут;
 - удаления контейнера;
 - проброса порта локальной машины в контейнер для отладки.

2. В качестве решения пришлите получившиеся команды.

### Решение 3
> Команды
> ``` kubectl exec -it redis-7bfccd74cd-m49ng -- ps aux ``` \
> ``` kubectl logs --since=5m redis-7bfccd74cd-m49ng ``` \
> ``` kubectl delete -f redis-netology.yaml && kubectl delete -f redis-netology-service.yam ``` \
> ``` kubectl port-forward pod/redis-7bfccd74cd-m49ng 54321:6379 ``` \

![image](https://github.com/ADNikulin/netology/assets/44374132/d54ebfb8-c9ee-4215-a274-dc60bab86263)

------
## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 4*

Есть конфигурация nginx:

```
location / {
    add_header Content-Type text/plain;
    return 200 'Hello from k8s';
}
```

**Выполните действия:**

1. Напишите yaml-файлы для развёртки nginx, в которых будут присутствовать:

 - ConfigMap с конфигом nginx;
 - Deployment, который бы подключал этот configmap;
 - Ingress, который будет направлять запросы по префиксу /test на наш сервис.

2. В качестве решения пришлите получившийся файл.

### Решение 4

> ConfigMap
```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  labels:
    app: nginx
data:
  nginx-location.conf: |
      server {
        location / {
          add_header Content-Type text/plain;
          return 200 'Hello from k8s';
        }
      }
```
> Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.25.0
          ports:
            - containerPort: 80
              name: nginx-port
          volumeMounts:
            - name: nginx-config
              mountPath: /etc/nginx/conf.d/nginx-location.conf
              subPath: nginx-location.conf
      volumes:
        - name: nginx-config
          configMap:
            name: nginx-config

```
> Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx-service
spec:
  selector:
    app: nginx
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80

```
> Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
spec:
  rules:
    - http:
        paths:
          - path: /test
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80

```
