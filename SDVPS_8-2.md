# 8.2. CI/CD — Никулин Александр
# Домашнее задание к занятию «Что такое DevOps. СI/СD»

---

### Задание 1

**Что нужно сделать:**

1. Установите себе jenkins по инструкции из лекции или любым другим способом из официальной документации. Использовать Docker в этом задании нежелательно.
2. Установите на машину с jenkins [golang](https://golang.org/doc/install).
3. Используя свой аккаунт на GitHub, сделайте себе форк [репозитория](https://github.com/netology-code/sdvps-materials.git). В этом же репозитории находится [дополнительный материал для выполнения ДЗ](https://github.com/netology-code/sdvps-materials/blob/main/CICD/8.2-hw.md).
3. Создайте в jenkins Freestyle Project, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта ```go test .``` и  ```docker build .```.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Решение 1

<details>
  <summary>скрины настроек</summary>
  
  > Настроил две виртуальные машины и накатил туда дженкинс и нексус \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/c7ead3e7-01c1-4e05-9cd3-5d8d66ad27fb) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/cecabcb4-f523-4c29-9a31-fc466a470a87) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/4a82010f-12b2-47c0-8100-8f8a26fd7a1b) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/c42b5152-8b9a-468b-8652-1d68c3ccd471) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/8453d14d-7695-49b8-8f2f-66299d5e8f0f) 
</details> 
  
<details>
  <summary>Лог сборки</summary>
  
  ```
  Started by user Никулин Александр
  Running as SYSTEM
  Building in workspace /var/lib/jenkins/workspace/Projects.8-2.Test
  The recommended git tool is: NONE
  No credentials specified
  Cloning the remote Git repository
  Cloning repository https://github.com/ADNikulin/sdvps-materials.git/
   > git init /var/lib/jenkins/workspace/Projects.8-2.Test # timeout=10
  Fetching upstream changes from https://github.com/ADNikulin/sdvps-materials.git/
   > git --version # timeout=10
   > git --version # 'git version 2.17.1'
   > git fetch --tags --progress -- https://github.com/ADNikulin/sdvps-materials.git/ +refs/heads/*:refs/remotes/origin/* # timeout=10
   > git config remote.origin.url https://github.com/ADNikulin/sdvps-materials.git/ # timeout=10
   > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
  Avoid second fetch
   > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
  Checking out Revision 223dbc3f489784448004e020f2ef224f17a7b06d (refs/remotes/origin/main)
   > git config core.sparsecheckout # timeout=10
   > git checkout -f 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  Commit message: "Update README.md"
  First time build. Skipping changelog.
  [Projects.8-2.Test] $ /bin/sh -xe /tmp/jenkins4441506615887807084.sh
  + /usr/local/go/bin/go test .
  ok  	github.com/netology-code/sdvps-materials	0.001s
  [Projects.8-2.Test] $ /bin/sh -xe /tmp/jenkins6336848651231527160.sh
  + docker build .
  #1 [internal] load build definition from Dockerfile
  #1 DONE 0.0s
  
  #2 [internal] load .dockerignore
  #2 transferring context: 2B done
  #2 DONE 0.4s
  
  #1 [internal] load build definition from Dockerfile
  #1 transferring dockerfile: 350B done
  #1 DONE 0.4s
  
  #3 [internal] load metadata for docker.io/library/golang:1.16
  #3 ...
  
  #4 [internal] load metadata for docker.io/library/alpine:latest
  #4 DONE 1.8s
  
  #3 [internal] load metadata for docker.io/library/golang:1.16
  #3 DONE 2.0s
  
  #5 [internal] load build context
  #5 DONE 0.0s
  
  #6 [stage-1 1/3] FROM docker.io/library/alpine:latest@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a
  #6 resolve docker.io/library/alpine:latest@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a 0.0s done
  #6 ...
  
  #5 [internal] load build context
  #5 transferring context: 100.33kB 0.0s done
  #5 DONE 0.0s
  
  #6 [stage-1 1/3] FROM docker.io/library/alpine:latest@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a
  #6 sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a 1.64kB / 1.64kB done
  #6 sha256:c5c5fda71656f28e49ac9c5416b3643eaa6a108a8093151d6d1afc9463be8e33 528B / 528B done
  #6 sha256:7e01a0d0a1dcd9e539f8e9bbd80106d59efbdf97293b3d38f5d7a34501526cdb 1.47kB / 1.47kB done
  #6 sha256:7264a8db6415046d36d16ba98b79778e18accee6ffa71850405994cffa9be7de 0B / 3.40MB 0.2s
  #6 sha256:7264a8db6415046d36d16ba98b79778e18accee6ffa71850405994cffa9be7de 3.40MB / 3.40MB 0.3s done
  #6 extracting sha256:7264a8db6415046d36d16ba98b79778e18accee6ffa71850405994cffa9be7de
  #6 extracting sha256:7264a8db6415046d36d16ba98b79778e18accee6ffa71850405994cffa9be7de 0.1s done
  #6 DONE 0.6s
  
  #7 [builder 1/4] FROM docker.io/library/golang:1.16@sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e
  #7 resolve docker.io/library/golang:1.16@sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e 0.0s done
  #7 sha256:35fa3cfd4ec01a520f6986535d8f70a5eeef2d40fb8019ff626da24989bdd4f1 1.80kB / 1.80kB done
  #7 sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e 2.35kB / 2.35kB done
  #7 sha256:e4d61adff2077d048c6372d73c41b0bd68f525ad41f5530af05098a876683055 28.31MB / 54.92MB 0.5s
  #7 sha256:4ff1945c672b08a1791df62afaaf8aff14d3047155365f9c3646902937f7ffe6 5.15MB / 5.15MB 0.4s done
  #7 sha256:972d8c0bc0fc7d67045f744b6949c2884e6c64bc6b262d511a853b4b5aeb0d23 7.05kB / 7.05kB done
  #7 sha256:ff5b10aec998344606441aec43a335ab6326f32aae331aab27da16a6bb4ec2be 495.62kB / 10.87MB 0.5s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 0B / 54.58MB 0.5s
  #7 sha256:e4d61adff2077d048c6372d73c41b0bd68f525ad41f5530af05098a876683055 54.92MB / 54.92MB 0.7s
  #7 sha256:ff5b10aec998344606441aec43a335ab6326f32aae331aab27da16a6bb4ec2be 10.87MB / 10.87MB 0.7s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 14.68MB / 54.58MB 0.7s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 25.17MB / 54.58MB 0.8s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 32.51MB / 54.58MB 0.9s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 49.28MB / 54.58MB 1.2s
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 54.58MB / 54.58MB 1.4s
  #7 sha256:e4d61adff2077d048c6372d73c41b0bd68f525ad41f5530af05098a876683055 54.92MB / 54.92MB 1.5s done
  #7 sha256:ff5b10aec998344606441aec43a335ab6326f32aae331aab27da16a6bb4ec2be 10.87MB / 10.87MB 1.5s done
  #7 extracting sha256:e4d61adff2077d048c6372d73c41b0bd68f525ad41f5530af05098a876683055
  #7 sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 54.58MB / 54.58MB 2.7s done
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 0B / 129.16MB 2.8s
  #7 sha256:245345d44ed8225f5d3f80fb591b72fddeb8e40e1020926849fcaf0aac1ed060 0B / 156B 2.8s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 0B / 85.81MB 2.8s
  #7 sha256:245345d44ed8225f5d3f80fb591b72fddeb8e40e1020926849fcaf0aac1ed060 156B / 156B 3.0s done
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 17.83MB / 85.81MB 3.1s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 18.69MB / 129.16MB 3.2s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 31.46MB / 85.81MB 3.2s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 50.33MB / 129.16MB 3.4s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 53.48MB / 85.81MB 3.4s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 62.91MB / 129.16MB 3.5s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 65.01MB / 85.81MB 3.5s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 79.69MB / 129.16MB 3.6s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 77.59MB / 85.81MB 3.6s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 95.42MB / 129.16MB 3.7s
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 85.81MB / 85.81MB 3.7s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 114.29MB / 129.16MB 3.8s
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 129.16MB / 129.16MB 4.0s
  #7 extracting sha256:e4d61adff2077d048c6372d73c41b0bd68f525ad41f5530af05098a876683055 2.8s done
  #7 sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 85.81MB / 85.81MB 5.7s done
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 129.16MB / 129.16MB 9.1s
  #7 extracting sha256:4ff1945c672b08a1791df62afaaf8aff14d3047155365f9c3646902937f7ffe6
  #7 sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 129.16MB / 129.16MB 9.8s done
  #7 ...
  
  #8 [stage-1 2/3] RUN apk -U add ca-certificates
  #0 4.053 fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/main/x86_64/APKINDEX.tar.gz
  #0 5.212 fetch https://dl-cdn.alpinelinux.org/alpine/v3.18/community/x86_64/APKINDEX.tar.gz
  #0 5.571 (1/1) Installing ca-certificates (20230506-r0)
  #0 5.631 Executing busybox-1.36.1-r2.trigger
  #0 6.509 Executing ca-certificates-20230506-r0.trigger
  #0 6.537 OK: 8 MiB in 16 packages
  #8 ...
  
  #7 [builder 1/4] FROM docker.io/library/golang:1.16@sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e
  #7 extracting sha256:4ff1945c672b08a1791df62afaaf8aff14d3047155365f9c3646902937f7ffe6 0.9s done
  #7 ...
  
  #8 [stage-1 2/3] RUN apk -U add ca-certificates
  #8 DONE 11.2s
  
  #7 [builder 1/4] FROM docker.io/library/golang:1.16@sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e
  #7 extracting sha256:ff5b10aec998344606441aec43a335ab6326f32aae331aab27da16a6bb4ec2be
  #7 extracting sha256:ff5b10aec998344606441aec43a335ab6326f32aae331aab27da16a6bb4ec2be 0.3s done
  #7 extracting sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02
  #7 extracting sha256:12de8c754e45686ace9e25d11bee372b070eed5b5ab20aa3b4fab8c936496d02 2.2s done
  #7 extracting sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36
  #7 extracting sha256:8c86ff77a3175ed4d7958578d141a96b5da005855d60ea24067de33cd62e4c36 2.1s done
  #7 extracting sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa
  #7 extracting sha256:0395a1c478ba68635e5d1bc9349b8fddba5584adc454cec751cd3f29af9080aa 3.7s done
  #7 extracting sha256:245345d44ed8225f5d3f80fb591b72fddeb8e40e1020926849fcaf0aac1ed060 done
  #7 DONE 28.9s
  
  #9 [builder 2/4] WORKDIR /go/src/github.com/netology-code/sdvps-materials
  #9 DONE 4.8s
  
  #10 [builder 3/4] COPY . ./
  #10 DONE 0.4s
  
  #11 [builder 4/4] RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app .
  #11 DONE 4.7s
  
  #12 [stage-1 3/3] COPY --from=builder /app /app
  #12 DONE 0.1s
  
  #13 exporting to image
  #13 exporting layers
  #13 exporting layers 8.1s done
  #13 writing image sha256:d48e4cb91a245e612ede0aa9d02a3f7a06d628131d442bfcfa7702d08beb7f26 done
  #13 DONE 8.1s
  Finished: SUCCESS
  ```
</details>

---

### Задание 2

**Что нужно сделать:**

1. Создайте новый проект pipeline.
2. Перепишите сборку из задания 1 на declarative в виде кода.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Решение 2

<details>
  <summary>Скрины решения</summary>
  
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/f08d4140-007a-4d9b-9595-f2e7654a7ab6) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/11b9a47b-0b5d-4161-afbf-335a62c0a479) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/c4669068-29ac-44af-9c9d-ef75a12ff787) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/4a968870-86e3-4a53-a805-be59c0debf77)
</details>

<details>
  <summary>Лог сборки</summary>
  
  ```
  Started by user Никулин Александр
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/Projects.8-2.Test2
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Projects.8-2.Test2/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/ADNikulin/sdvps-materials.git/ # timeout=10
Fetching upstream changes from https://github.com/ADNikulin/sdvps-materials.git/
 > git --version # timeout=10
 > git --version # 'git version 2.17.1'
 > git fetch --tags --progress -- https://github.com/ADNikulin/sdvps-materials.git/ +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 223dbc3f489784448004e020f2ef224f17a7b06d (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
Commit message: "Update README.md"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build)
[Pipeline] sh
+ /usr/local/go/bin/go test .
ok  	github.com/netology-code/sdvps-materials	0.001s
[Pipeline] sh
+ docker build .
#1 [internal] load .dockerignore
#1 transferring context: 2B done
#1 DONE 0.0s

#2 [internal] load build definition from Dockerfile
#2 transferring dockerfile: 350B done
#2 DONE 0.1s

#3 [internal] load metadata for docker.io/library/golang:1.16
#3 DONE 1.4s

#4 [internal] load metadata for docker.io/library/alpine:latest
#4 DONE 1.5s

#5 [builder 1/4] FROM docker.io/library/golang:1.16@sha256:5f6a4662de3efc6d6bb812d02e9de3d8698eea16b8eb7281f03e6f3e8383018e
#5 DONE 0.0s

#6 [stage-1 1/3] FROM docker.io/library/alpine:latest@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a
#6 DONE 0.0s

#7 [internal] load build context
#7 transferring context: 100.93kB 0.0s done
#7 DONE 0.0s

#8 [builder 2/4] WORKDIR /go/src/github.com/netology-code/sdvps-materials
#8 CACHED

#9 [builder 3/4] COPY . ./
#9 DONE 0.1s

#10 [builder 4/4] RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app .
#10 DONE 4.2s

#11 [stage-1 2/3] RUN apk -U add ca-certificates
#11 CACHED

#12 [stage-1 3/3] COPY --from=builder /app /app
#12 CACHED

#13 exporting to image
#13 exporting layers done
#13 writing image sha256:d48e4cb91a245e612ede0aa9d02a3f7a06d628131d442bfcfa7702d08beb7f26 0.0s done
#13 DONE 0.0s
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
  ```
</details>

---

### Задание 3

**Что нужно сделать:**

1. Установите на машину Nexus.
1. Создайте raw-hosted репозиторий.
1. Измените pipeline так, чтобы вместо Docker-образа собирался бинарный go-файл. Команду можно скопировать из Dockerfile.
1. Загрузите файл в репозиторий с помощью jenkins.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Решение 3

<details>
  <summary>Скрины для решения</summary>
  
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/2cde142e-da90-4cea-a0db-365f934ba98f) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/a1e17821-a1d9-454d-a035-869b46220aee) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/f389e7aa-9d1c-4120-925a-abf5c1eb69d9) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/b396c812-f481-407f-9b44-d554a121e63e)
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/20e45606-a8da-4028-8acd-caaa07ea3b7a)

</details>

<details>
  <summary>Лог сборки</summary>
  
  ```
  Started by user Никулин Александр
  [Pipeline] Start of Pipeline
  [Pipeline] node
  Running on Jenkins in /var/lib/jenkins/workspace/Projects.8-2.Test.3-1
  [Pipeline] {
  [Pipeline] stage
  [Pipeline] { (Git)
  [Pipeline] git
  The recommended git tool is: NONE
  No credentials specified
  Cloning the remote Git repository
  Cloning repository https://github.com/ADNikulin/sdvps-materials.git/
   > git init /var/lib/jenkins/workspace/Projects.8-2.Test.3-1 # timeout=10
  Fetching upstream changes from https://github.com/ADNikulin/sdvps-materials.git/
   > git --version # timeout=10
   > git --version # 'git version 2.17.1'
   > git fetch --tags --progress -- https://github.com/ADNikulin/sdvps-materials.git/ +refs/heads/*:refs/remotes/origin/* # timeout=10
   > git config remote.origin.url https://github.com/ADNikulin/sdvps-materials.git/ # timeout=10
   > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
  Avoid second fetch
   > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
  Checking out Revision 223dbc3f489784448004e020f2ef224f17a7b06d (refs/remotes/origin/main)
   > git config core.sparsecheckout # timeout=10
   > git checkout -f 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
   > git branch -a -v --no-abbrev # timeout=10
   > git checkout -b main 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  Commit message: "Update README.md"
  First time build. Skipping changelog.
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Build an Test)
  [Pipeline] sh
  + /usr/local/go/bin/go test .
  ok  	github.com/netology-code/sdvps-materials	0.001s
  [Pipeline] sh
  + /usr/local/go/bin/go build -a -installsuffix nocgo -o /builds/app .
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Push)
  [Pipeline] sh
  + curl -u admin:admin http://158.160.18.224:8081/repository/svdps-8_2/ --upload-file /builds/app
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  
    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    0 1821k    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] }
  [Pipeline] // node
  [Pipeline] End of Pipeline
  Finished: SUCCESS
  ```
</details>

---
## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 4*

Придумайте способ версионировать приложение, чтобы каждый следующий запуск сборки присваивал имени файла новую версию. Таким образом, в репозитории Nexus будет храниться история релизов.

Подсказка: используйте переменную BUILD_NUMBER.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

### Решение 4*

<details>
  <summary>Скрины к выполнению</summary>

  > ![image](https://github.com/ADNikulin/netology/assets/44374132/2549776e-6234-47e0-b241-7c7dc6179360) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/422aa3be-1dcf-404f-8ffd-194775eda523) \
  > ![image](https://github.com/ADNikulin/netology/assets/44374132/6f772d17-7642-42bf-97d7-bbd578db4051)

</details>

<details>
  <summary>Логи сборки #4</summary>

  ```
  Started by user Никулин Александр
  [Pipeline] Start of Pipeline
  [Pipeline] node
  Running on Jenkins in /var/lib/jenkins/workspace/Projects.8-2.Test.3-1
  [Pipeline] {
  [Pipeline] stage
  [Pipeline] { (Git)
  [Pipeline] git
  The recommended git tool is: NONE
  No credentials specified
   > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Projects.8-2.Test.3-1/.git # timeout=10
  Fetching changes from the remote Git repository
   > git config remote.origin.url https://github.com/ADNikulin/sdvps-materials.git/ # timeout=10
  Fetching upstream changes from https://github.com/ADNikulin/sdvps-materials.git/
   > git --version # timeout=10
   > git --version # 'git version 2.17.1'
   > git fetch --tags --progress -- https://github.com/ADNikulin/sdvps-materials.git/ +refs/heads/*:refs/remotes/origin/* # timeout=10
   > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
  Checking out Revision 223dbc3f489784448004e020f2ef224f17a7b06d (refs/remotes/origin/main)
   > git config core.sparsecheckout # timeout=10
   > git checkout -f 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
   > git branch -a -v --no-abbrev # timeout=10
   > git branch -D main # timeout=10
   > git checkout -b main 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  Commit message: "Update README.md"
   > git rev-list --no-walk 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Build an Test)
  [Pipeline] sh
  + /usr/local/go/bin/go test .
  ok  	github.com/netology-code/sdvps-materials	(cached)
  [Pipeline] sh
  + /usr/local/go/bin/go build -a -installsuffix nocgo -o /builds/app.v.4 .
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Push)
  [Pipeline] sh
  + curl -u admin:123 http://158.160.18.224:8081/repository/svdps-8_2/ --upload-file /builds/app.v.4
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  
    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  100 1821k    0     0  100 1821k      0  33.5M --:--:-- --:--:-- --:--:-- 33.5M
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] }
  [Pipeline] // node
  [Pipeline] End of Pipeline
  Finished: SUCCESS
  ```
</details>

<details>
  <summary>Логи сборки #5</summary>

  ```
  Started by user Никулин Александр
  [Pipeline] Start of Pipeline
  [Pipeline] node
  Running on Jenkins in /var/lib/jenkins/workspace/Projects.8-2.Test.3-1
  [Pipeline] {
  [Pipeline] stage
  [Pipeline] { (Git)
  [Pipeline] git
  The recommended git tool is: NONE
  No credentials specified
   > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Projects.8-2.Test.3-1/.git # timeout=10
  Fetching changes from the remote Git repository
   > git config remote.origin.url https://github.com/ADNikulin/sdvps-materials.git/ # timeout=10
  Fetching upstream changes from https://github.com/ADNikulin/sdvps-materials.git/
   > git --version # timeout=10
   > git --version # 'git version 2.17.1'
   > git fetch --tags --progress -- https://github.com/ADNikulin/sdvps-materials.git/ +refs/heads/*:refs/remotes/origin/* # timeout=10
   > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
  Checking out Revision 223dbc3f489784448004e020f2ef224f17a7b06d (refs/remotes/origin/main)
   > git config core.sparsecheckout # timeout=10
   > git checkout -f 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
   > git branch -a -v --no-abbrev # timeout=10
   > git branch -D main # timeout=10
   > git checkout -b main 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  Commit message: "Update README.md"
   > git rev-list --no-walk 223dbc3f489784448004e020f2ef224f17a7b06d # timeout=10
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Build an Test)
  [Pipeline] sh
  + /usr/local/go/bin/go test .
  ok  	github.com/netology-code/sdvps-materials	(cached)
  [Pipeline] sh
  + /usr/local/go/bin/go build -a -installsuffix nocgo -o /builds/app.v.5 .
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Push)
  [Pipeline] sh
  + curl -u admin:123 http://158.160.18.224:8081/repository/svdps-8_2/ --upload-file /builds/app.v.5
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  
    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  100 1821k    0     0  100 1821k      0  23.4M --:--:-- --:--:-- --:--:-- 23.4M
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] }
  [Pipeline] // node
  [Pipeline] End of Pipeline
  Finished: SUCCESS
  ```
</details>
