Чалков Артем Валериевич
<br />Когорта: 12
<br />Группа: 3
<br />Эпик: Профиль
<br />Ссылка: [Projects](https://github.com/users/ArtemChalkov/projects/1)

#  Profile Flow Decomposition

## Module 1: Экран профиля

#### Верстка
- Главный экрана профиль (est: 240 min; fact: x min).
- Экран Редактирования профиля (est: 240 min; fact: x min).

#### Логика
- Запрос на профиль (est: 60 min; fact: x min).
- Запрос изменение профиля (имя, описание, сайт) (est: 120 min; fact: x min).

`Total:` est: 660 min; fact: x min.

## Module 2: Экран мои NFT

#### Верстка
- Мой NFT (est: 240 min; fact: x min)
- Мой NFT (нулевой экран) (est: 60 min; fact: x min).
- Фильтрация (est: 60 min; fact: x min).

#### Логика
- Логика на фильтрацию токенов (цена, рейтинг, название) (est: 60 min; fact: x min).
- Запрос на получение моих NFT токенов (est: 60 min; fact: x min).

`Total:` est: 480 min; fact: x min.


## Module 3: Экран избранные NFT

#### Верстка
- Избранное NFT (est: 240 min; fact: x min).
- Избранное NFT (нулевой экран) (est: 60 min; fact: x min).

#### Логика
- Запрос на получение избранных NFT токенов (est: 60 min; fact: x min).
- Запрос на лайк (est: 60 min; fact: x min).

`Total:` est: 420 min; fact: x min.

### Общая оценка времени
`Total: ` est: 1560 min; fact: x min.
