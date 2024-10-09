# Микросервисы. Никулин Александр. 
# Домашнее задание к занятию «Введение в микросервисы»

## Задача

Руководство крупного интернет-магазина, у которого постоянно растёт пользовательская база и количество заказов, рассматривает возможность переделки своей внутренней   ИТ-системы на основе микросервисов. 

Вас пригласили в качестве консультанта для оценки целесообразности перехода на микросервисную архитектуру. 

Опишите, какие выгоды может получить компания от перехода на микросервисную архитектуру и какие проблемы нужно решить в первую очередь.

<details>
  <summary>Раскрыть решение</summary>

  **Преимущества перехода на микросервисную архитектуру:**

  - Возможность масштабирования отдельных бизнес-компонентов, что позволяет распределять нагрузку более эффективно.
  - Гибкость разработки, возможность использовать более эффективные технологии для конкретных сервисов или задач.
  - Увеличенная отказоустойчивость за счет распределения сервисов на разные ноды, что минимизирует потерю функциональности при выходе из строя отдельной ноды.
  - Упрощение и ускорение внедрения или откатывания изменений отдельного сервиса.
  - Ясное распределение зон ответственности между командами, так как зоны ответственности теперь представляют собой отдельный сервис или группу сервисов.
  - Удобство ведения документации и написания кода, так как приложение будет поделено на логические части, которые будут взаимодействовать друг с другом.
  
  **Возможные проблемы при переходе на микросервисную архитектуру:**

  - Реорганизация штата сотрудников, так как при разделении на команды будут необходимы новые дополнительные специалисты (девопс-инженеры, тим-лиды, проджект-менеджеры и пр. специалисты, задействованные в CI/CD).
  - Необходимость рефакторинга уже имеющегося кода при переходе с монолитной системы на микросервисную.
  - Большие начальные трудо- и временные затраты, которые будут неизбежны, так как переход на микросервисную архитектуру будет происходить постепенно, соответственно будут появляться различные дополнительные проблемы и задачи, связанные как с персоналом, так и с приложением.
  - Осваивание новых технологий и обучение уже имеющихся специалистов, так как архитектура приложения станет сложнее, то и квалификация специалистов должна будет быть выше.

</details>