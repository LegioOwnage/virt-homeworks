# Домашнее задание к занятию "5.4. Оркестрация группой Docker контейнеров на примере Docker Compose"

## Задача 1

Создать собственный образ операционной системы с помощью Packer.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы, как на слайде из презентации (слайд 37).

Ответ: ![Screenshot from 2021-12-30 15-36-11](https://user-images.githubusercontent.com/89036206/147754211-c7f7adbe-e343-47e4-8dc4-4a146f6f215e.png)


## Задача 2

Создать вашу первую виртуальную машину в Яндекс.Облаке.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы свойств созданной ВМ, как на примере ниже:

<p align="center">
  <img width="1200" height="600" src="./assets/yc_01.png">
</p>

Ответ:
![Screenshot from 2022-01-03 18-50-03](https://user-images.githubusercontent.com/89036206/147951200-ae04a6f3-f8a8-462e-a86a-1e25d0b9488b.png)


## Задача 3

Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить:
- Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже
<p align="center">
  <img width="1200" height="600" src="./assets/yc_02.png">
</p>

Ответ: При попытке развернуть ansible-playbook возникает ошибка. Прошу помочь разбраться, почему не устанавливаются приложения. 
![Screenshot from 2022-01-03 19-43-14](https://user-images.githubusercontent.com/89036206/148116099-0ae1721d-0b9d-4928-9b08-0eb786722510.png)
![Screenshot from 2022-01-03 19-43-31](https://user-images.githubusercontent.com/89036206/148116207-5e8efaa5-7e55-4e2a-938b-adeea432e5d2.png)
Изменения provision на эти помогли (спасибо подсказке из slack), но почему так произошло и в чем суть изменений до конца не разобрался, прошу пояснить.


![Screenshot from 2022-01-07 18-34-06](https://user-images.githubusercontent.com/89036206/148567338-91015699-df41-41a8-8cf4-df6d9e7ed14c.png)


Ну и сам ответ на дз:
![Screenshot from 2022-01-07 18-30-28](https://user-images.githubusercontent.com/89036206/148567414-3bd713b0-aec8-4713-8d5e-a696e4ff3e8d.png)



## Задача 4 (*)

Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.

Для получения зачета, вам необходимо предоставить:
- Скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---