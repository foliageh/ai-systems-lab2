# GTA Recommendation System
Игровой мир GTA San Andreas, как известно, очень велик. 
В нем много локаций, персонажей, предметов, сюжетных линий и так далее.
Обычному игроку бывает сложно ориентироваться в таком большом мире - куда ехать, с кем общаться,
у каких персонажей брать миссии, понять, где что находится, и кто твой друг, а кто - враг.

Данная рекомендательная система предназначена для упрощения взаимодействия пользователя
с игровым миром и улучшение понимания происходящего в игре. Пользователь вводит в консоль вопросы
в фиксированном формате и получает информацию о персонажах, которые соответствуют его запросу
(более подробно об этом читайте в разделе "Взаимодействие с системой").

## Сборка и запуск через Docker
```shell
mvn clean package
docker-compose build
docker-compose run --rm app
```

## Взаимодействие с системой
**Формат запроса пользователя:**  
`(I'm character_name and) I need to find people (in location_name) who are <members of my gang|my friends|my allies|my enemies> (and who has a vehicle).`

Части запроса, взятые в скобки – опциональны.

**Примеры запросов:**
```
I'm woozie and I need to find people who are my enemies.

I need to find people who are members of my gang.

I'm big_smoke and I need to find people in los_santos who are my friends.

I need to find people who are my allies and who has a vehicle.
```

**Пример взаимодействия с системой:**
```
    Система:
Welcome to GTA San Andreas recommendation system!
Query format:
  (I'm character_name and) I need to find people (in location_name) who are <members of my gang|my friends|my allies|my enemies> (and who has a vehicle).

Enter your query:

    Пользователь:
I'm woozie and I need to find people who are my enemies.

    Система:
Found characters:
[t_bone_mendez, jizzy_b, mike_toreno]

Enter your query: 

    Пользователь:
I'm big_smoke and I need to find people in los_santos who are my friends.

    Система:
Found characters:
[sweet, ryder]

и т.д.
```