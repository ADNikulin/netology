# 10.2. Отказоустойчивость — Никулин Александр
# Домашнее задание к занятию 3 «Резервное копирование»

------

### Задание 1
- Составьте команду rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию `/tmp/backup`
- Необходимо исключить из синхронизации все директории, начинающиеся с точки (скрытые)
- Необходимо сделать так, чтобы rsync подсчитывал хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике.
- На проверку направить скриншот с командой и результатом ее выполнения

### Решение 1
<details>
  <summary>
    Решение
  </summary>

  - `rsync -ac --delete --exclude=".*/" . /tmp/backup`
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/98c3ef1a-5807-48ba-bfc1-c034d7afb9c6)

</details>


### Задание 2
- Написать скрипт и настроить задачу на регулярное резервное копирование домашней директории пользователя с помощью rsync и cron.
- Резервная копия должна быть полностью зеркальной
- Резервная копия должна создаваться раз в день, в системном логе должна появляться запись об успешном или неуспешном выполнении операции
- Резервная копия размещается локально, в директории `/tmp/backup`
- На проверку направить файл crontab и скриншот с результатом работы утилиты.

### Решение 2
<details>
  <summary>
    Решение
  </summary>

  - ```sh
    rsync -a --delete /home/anikulin/Projects/ /tmp/backup
    
    if [ "$?" -eq 0 ]; then
        logger "[rsync_proj] Backup - success"
    else    logger "[rsync_proj] Backup fail"
    fi
    ```
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/988e9d90-2e6a-410a-aa90-1c07723c9125)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/444f7acb-31b7-45f0-9c6e-90900eaa3b05)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/170c9323-a8ba-4eb2-9ac3-6547d22f811b)

</details>

---

## Задания со звёздочкой*
Эти задания дополнительные. Их можно не выполнять. На зачёт это не повлияет. Вы можете их выполнить, если хотите глубже разобраться в материале.

---

### Задание 3*
- Настройте ограничение на используемую пропускную способность rsync до 1 Мбит/c
- Проверьте настройку, синхронизируя большой файл между двумя серверами
- На проверку направьте команду и результат ее выполнения в виде скриншота

### Решение 3*
<details>
  <summary>
    Решение
  </summary>

  - `rsync -a --progress --bwlimit=1000 file.test user@84.201.161.147:/tmp`
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/2ff3ba3e-3556-48d7-b6db-04dfdeebbdbc)

</details>

### Задание 4*
- Напишите скрипт, который будет производить инкрементное резервное копирование домашней директории пользователя с помощью rsync на другой сервер
- Скрипт должен удалять старые резервные копии (сохранять только последние 5 штук)
- Напишите скрипт управления резервными копиями, в нем можно выбрать резервную копию и данные восстановятся к состоянию на момент создания данной резервной копии.
- На проверку направьте скрипт и скриншоты, демонстрирующие его работу в различных сценариях.

### Решение 4*
<details>
  <summary>
    Решение
  </summary>

  - `backup_incr.sh`
    ```
    #!/bin/bash
    name=`date +"%Y%m%d%H%M%S"`
    rsync -avz --progress --delete user@84.201.161.147:/home/user/ /tmp/current/ --backup --backup-dir=/tmp/increment/$name

    cd /tmp/increment/
    ls -t | tail -n +6 | xargs rm -rf --
    ```
  - `restore_backup_incr.sh`
    ```
    #!/bin/bash
   
    n=1 
    for file in /tmp/increment/*; do
        echo "$n - $(basename "$file")"
        ((n++))
    done
    
    read -p "Write number to restore (1-5): " x
    m=1
    for file in /tmp/increment/*; do
        if [ "$m" -le "$x" ]; then
            rsync -avz $file/ user@84.201.161.147:/home/user
        fi
        ((m++))
    done
    ```
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/37f45dd1-cf1e-4fe3-abad-693338e21a96)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/78e42700-375b-40fd-a7fc-613bde29d005)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/aea82655-88e7-43cb-b4b5-8e306e8296c1)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/44d0fd97-1527-462f-a869-573d828d01ac)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/ae1dc586-3c55-4434-963c-f0d16f156643)
  - ![image](https://github.com/ADNikulin/netology/assets/44374132/2d101169-4305-46e4-a3d5-862fa405116b)

</details>
------
