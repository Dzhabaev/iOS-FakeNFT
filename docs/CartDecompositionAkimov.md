Акимов Александр Андреевич
<br /> Когорта: 12
<br /> Группа: 3
<br /> Эпик: Корзина
<br /> Ссылка: https://github.com/users/Dzhabaev/projects/1/views/1


# Cart Flow Decomposition


## Module 1:

#### Верстка
- Страницы корзины (est: 90 min; fact: x min).
- Подтверждение удаления (est: 20 min; fact: x min).

#### Логика
- Сортировка (est: 80 min; fact: x min).
- Сохранить способ сортировки (est: 20 min; fact: x min).

`Total:` est: 210 min; fact: x min.


## Module 2:
#### Верстка
- Страница оплаты(est: 40 min; fact: x min).

#### Логика
- Реализация запроса наполнения корзины из сети (est: 90 min; fact: x min).
- Реализация запроса удаления из корзины (est: 90 min; fact: x min).
- Индикатор загрузки корзины (est: 30 min; fact: x min).


`Total:` est: 250 min; fact: x min.

## Module 3:
#### Верстка
- Алерт "Оплата не прошла" (est: 30 min; fact: x min).
- Страница успешной оплаты (est: 30 min; fact: x min).

#### Логика
- Реализация логики оплаты (est: 90 min; fact: x min).
- Реализация логики алерта "Оплата не прошла" (est: 60 min; fact: x min).
- Индикатор загрузки оплаты (est: 30 min; fact: x min).


`Total:` est: 240 min; fact: x min.
