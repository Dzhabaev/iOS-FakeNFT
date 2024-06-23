### FakeNFT

FakeNFT - это приложение для просмотра и "покупки" NFT (Non-Fungible Token), разработанное для iOS. Оно предоставляет пользователям возможность просматривать коллекции NFT и осуществлять имитацию покупок через моковый сервер.

#### Описание

FakeNFT демонстрирует каталог NFT, структурированных в виде коллекций. Пользователь может просматривать информацию о коллекциях, выбранных NFT, добавлять их в избранное, корзину, и имитировать оплату. Приложение также предоставляет возможность пользователям видеть рейтинги и профили других пользователей.

![ScreencastFakeNFT](https://github.com/Dzhabaev/iOS-FakeNFT/assets/137287126/ea49c1bb-c538-4401-abb9-40c4ee3cd633)

#### Инструкция по развёртыванию или использованию

Приложение использует API для получения данных, поэтому для полноценной работы требуется подключение к интернету.

Для запуска приложения необходимо клонировать репозиторий и запустить проект в Xcode выполнив следующие шаги:

1. Клонировать репозиторий на локальную машину:

   ```shell
   git clone https://github.com/Dzhabaev/iOS-FakeNFT.git
   ```

2. Перейти в папку проекта, к примеру:

   ```shell
   cd ~
   cd iOS-FakeNFT
   ```

3. Открыть проект с помощью Xcode:

   ```shell
   open iOS-FakeNFT.xcodeproj
   ```

4. Запустить проект на симуляторе или устройстве.

#### Системные требования

- Xcode 12.0 или выше
- Swift 5.3 или выше
- iOS 13.0 или выше
- Предусмотрен только портретный режим
- Вёрстка под SE и iPad не предусмотрена
- Зависимости: Alamofire, Kingfisher, ProgressHUD

#### Планы по доработке

В планах по доработке:

- Добавление локализации для поддержки нескольких языков.
- Поддержка тёмной темы.
- Интеграция статистики на основе Яндекс Метрики.
- Реализация экрана авторизации.
- Добавление экрана онбординга.
- Внедрение алерта с предложением оценить приложение.
- Отображение сообщений о сетевых ошибках.
- Создание кастомного launch screen.
- Реализация поиска по таблице/коллекции.

#### Стек технологий

Проект использует:

- Swift для разработки мобильного приложения.
- UIKit для построения пользовательского интерфейса.
- MVP (Model-View-Presenter) архитектура.
- SPM (Swift Package Manager) для управления зависимостями.

#### Расширенная техническая документация

##### Ссылки

- [Дизайн Figma](https://www.figma.com/file/k1LcgXHGTHIeiCv4XuPbND/FakeNFT-(YP)?node-id=96-5542&t=YdNbOI8EcqdYmDeg-0)

##### Основная структура проекта

- `Application`: Содержит `AppDelegate` и `SceneDelegate`, которые управляют жизненным циклом приложения.
- `Resources`: Ресурсы приложения, такие как `Assets`, `Info`, `LaunchScreen`, `Localizable`.
- `DesignSystem`: Общие элементы дизайна, такие как цвета (`Colors`) и шрифты (`Fonts`).
- `Foundation`: Основные утилиты и сервисы:
  - `MemoryStorage`: Модуль для работы с памятью.
  - `NetworkClient`: Модуль для выполнения сетевых запросов.
  - `CellsReusingUtils`: Утилиты для переиспользования ячеек.
  - `DateFormatters+Presets`: Предустановленные форматтеры для дат.
  - `UIView+Constraints`: Расширения для удобной работы с ограничениями.
  - `UIBlockingProgressHUD`: Кастомный компонент для отображения прогресса.
- `Models`: Модели данных, используемые в приложении, такие как `Cart`, `Nft`, `ProfileModel` и другие.
- `Scenes`: Основные экраны приложения:
  - `TabBarController`: Главный контроллер вкладок.
  - `Common`: Общие представления и компоненты, такие как `Views` (например, `LinePageControl`, `LoadingView`, `ErrorView`).
  - `Profile`: Модули, связанные с профилем пользователя (`ProfileConfigurator`, `ProfileViewController`, `ProfilePresenter`, `ProfileProvider` и т.д.).
  - `Catalog`: Модули, связанные с каталогом NFT (`CatalogViewController`, `CatalogPresenter`, `CollectionDetailsViewController`, `CollectionDetailsPresenter`, и т.д.).
  - `Cart`: Модули, связанные с корзиной покупок (`CartViewController`, `CartPresenter`, `CartWebViewController` и т.д.).
  - `Statistics`: Модули для работы со статистикой (`StatisticsViewController`, `StatisticPresenter`, `StatisticService` и т.д.).
  - `NftDetails`: Модули для отображения деталей NFT (`NftDetailViewController`, `NftDetailPresenter`, и т.д.).
- `Services`: Различные сервисы, включая сетевые (`Network`, `NFTNetworkService`, `CartSortService`).
- `Extensions`: Расширения для удобства работы с различными типами данных (`URLRequest+Debug`, `Data+PrettyJSON`).

#### Настройка CI для запуска

Проект можно интегрировать с любой CI/CD системой, поддерживающей сборку проектов Swift и Xcode.

#### Создатели

@Dzhabaev @smoke0030 @antuturu @ArtemChalkov
