Джабаев Чингиз Абдурасулович
<br />Когорта: 12
<br />Группа: 3
<br />Эпик: Каталог
<br />Ссылка: [Projects](https://github.com/users/Dzhabaev/projects/1)

# Catalog Flow Decomposition

## Module 1: Catalog UI

### Экран каталога (UITableView)

#### Верстка
- Создание экрана каталога с таблицей (UITableView) для отображения коллекций NFT (est: 240 min; fact: x min).
  - Добавление заголовка "Каталог" (est: 40 min; fact: x min).
  - Добавление индикатора загрузки данных (est: 40 min; fact: x min).
  - Создание ячейки для отображения каждой коллекции NFT (est: 160 min; fact: x min).
    - Добавление обложки коллекции (est: 40 min; fact: x min).
    - Добавление названия коллекции (est: 40 min; fact: x min).
    - Добавление количества NFT в коллекции (est: 80 min; fact: x min).

#### Логика
- Загрузка данных для отображения каталога с сервера (est: 180 min; fact: x min).
- Реализация функционала сортировки коллекций по различным критериям (est: 200 min; fact: x min).
- Обработка нажатия на ячейку коллекции для перехода к экрану деталей коллекции (est: 120 min; fact: x min).

`Total:` est: 740 min; fact: x min.

## Module 2: Collection Details

### Экран деталей коллекции NFT

#### Верстка
- Создание экрана деталей коллекции NFT (est: 320 min; fact: x min).
  - Добавление обложки коллекции NFT (est: 60 min; fact: x min).
  - Добавление названия коллекции NFT (est: 50 min; fact: x min).
  - Добавление текстового описания коллекции NFT (est: 80 min; fact: x min).
  - Добавление имени автора коллекции с ссылкой на его сайт (est: 100 min; fact: x min).
  - Создание коллекции NFT с использованием UICollectionView (est: 80 min; fact: x min).
    - Добавление изображения NFT (est: 30 min; fact: x min).
    - Добавление названия NFT (est: 30 min; fact: x min).
    - Добавление рейтинга NFT (est: 30 min; fact: x min).
    - Добавление стоимости NFT в ETH (est: 30 min; fact: x min).
    - Добавление кнопки для добавления в избранное и корзину (est: 30 min; fact: x min).

#### Логика
- Загрузка данных для отображения деталей коллекции с сервера (est: 180 min; fact: x min).
- Обработка нажатия на имя автора коллекции для открытия его сайта (est: 120 min; fact: x min).

`Total:` est: 880 min; fact: x min.

## Module 3: User Interaction

### Взаимодействие с пользователем

#### Логика
- Реализация функционала добавления и удаления NFT из избранного (est: 180 min; fact: x min).
- Реализация функционала добавления и удаления NFT из корзины (est: 180 min; fact: x min).

`Total:` est: 360 min; fact: x min.

### Общая оценка времени
`Total: ` est: 1980 min; fact: x min.
