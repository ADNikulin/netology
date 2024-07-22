# 18.5 Виртуализация и контейнеризация.  Никулин Александр
# Домашнее задание к занятию 6. «Оркестрация кластером Docker контейнеров на примере Docker Swarm»

#### Это задание для самостоятельной отработки навыков и не предполагает обратной связи от преподавателя. Его выполнение не влияет на завершение модуля. Но мы рекомендуем его выполнить, чтобы закрепить полученные знания. Все вопросы, возникающие в процессе выполнения заданий, пишите в учебный чат или в раздел "Вопросы по заданиям" в личном кабинете.

---

## Важно

**Перед началом работы над заданием изучите [Инструкцию по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**
Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

[Ссылки для установки открытого ПО](https://github.com/netology-code/devops-materials/blob/master/README.md).

---

## Задача 1

<details>
  <summary>Задача</summary>
  
  Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке.
  Документация swarm: https://docs.docker.com/engine/reference/commandline/swarm_init/
  1. Создайте 3 облачные виртуальные машины в одной сети.
  2. Установите docker на каждую ВМ.
  3. Создайте swarm-кластер из 1 мастера и 2-х рабочих нод.
  
  4. Проверьте список нод командой:
  ```
  docker node ls
  ```

</details>

<details>
  <summary>Решение</summary>

  0. Сделал 3+3
  1. подгтовил террафформ конфиги + ansible - за основу подготовил свои.
  2. https://github.com/ADNikulin/docker-swarm-fast-example
  3. произвел авторизацию с яндекс консолью
  4. ```sh
     terraform init
     terraform paln
     terraform apply
     ```
  5. На выходе настроен аутпут файл, который генерит любое количество воркеров и менеджеров и записывает их в инвентарь
  6. запускаем и получаем на выходе настроенные машинки: \
     ![image](https://github.com/user-attachments/assets/bb6cd9eb-7c8e-4fb4-9db1-be13854e74f2)
  7. + настроенный inventory \
     ![image](https://github.com/user-attachments/assets/03d43473-d5e8-4f08-b061-3d11c853022f)
  8. запускаем ansible
     ```sh
     ansible-playbook playbook.yaml -i inventory.yaml 
     ```
  9. ![image](https://github.com/user-attachments/assets/efd2529f-d641-4615-a128-795b2a62324c)
  10. ![image](https://github.com/user-attachments/assets/9e2404eb-adfd-403d-bbbe-a2f9e363fec9)
  11. ![image](https://github.com/user-attachments/assets/38d3b6d0-c405-428e-a319-c385466a892c)
  12. МОжно было бы настроить ещё и настройку кластера через энсибл, но решил пока руками. (А так на будущее - https://github.com/sergey-gr/ansible-docker-swarm-cluster/blob/main/README.md или https://github.com/netology-code/virtd-homeworks/blob/shvirtd-1/05-virt-05-docker-swarm/src/ansible/swarm-deploy-cluster.yml) 
  13. ![image](https://github.com/user-attachments/assets/5cecf482-09f5-4d33-9c21-0bfb655a7565)
  14. ![image](https://github.com/user-attachments/assets/0c808228-1fc8-4c1e-a0ab-ebc32eb8995c)
  15. ![image](https://github.com/user-attachments/assets/76f6ec40-7eab-4135-8de5-d93bf43f4c69)
  16. ![image](https://github.com/user-attachments/assets/b78ee9e3-bcfa-4cf6-b4c5-fff8a6fd8edb)
  17. ![image](https://github.com/user-attachments/assets/4c5f4136-6344-4e26-b8a0-28acfe84d2c6)
  18. ![image](https://github.com/user-attachments/assets/a23a249c-60f2-4311-aca1-64711da9f56a)
  19. ![image](https://github.com/user-attachments/assets/12a5d3ed-41cd-4328-9cc3-f2ab3c7eb999)
  20. 


</details>

## Задача 2 (*) (необязательное задание *).
<details>
  <summary>Задача</summary>
    
  1.  Задеплойте ваш python-fork из предыдущего ДЗ(05-virt-04-docker-in-practice) в получившийся кластер.
  2. Удалите стенд.

</details>

<details>
  <summary>Решение</summary>

  - ![image](https://github.com/user-attachments/assets/81c1c83f-aa87-40c6-a9f9-0b51733343f8)
  - ![image](https://github.com/user-attachments/assets/568523a6-97d8-4d72-8492-35ba9a3281e6)


</details>
  
## Задача 3 (*)

<details>
  <summary>Задача</summary>

  Если вы уже знакомы с terraform и ansible  - повторите практику по примеру лекции "Развертывание стека микросервисов в Docker Swarm кластере". Попробуйте улучшить пайплайн, запустив ansible через terraform синамическим инвентарем.
  
  Проверьте доступность grafana.
  
  Иначе вернитесь к выполнению задания после прохождения модулей "terraform" и "ansible".
  
</details>

<details>
  <summary>Решение</summary>

  > Собственно выполнил всё в пункте 1.
  > ![image](https://github.com/user-attachments/assets/6adf08ff-eaea-4881-86f6-3c8ffdb90a8a) \
  > 

</details>
