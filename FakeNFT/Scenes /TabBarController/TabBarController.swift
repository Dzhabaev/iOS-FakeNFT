import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - ProfileViewController
        
        let profileViewController = ProfileConfigurator().configure()

        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.profile", comment: ""),
            image: UIImage(systemName: "person.crop.circle.fill"),
            selectedImage: nil
        )

        // MARK: - CatalogViewController

        let catalogViewController = CatalogViewController()
        catalogViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.catalog", comment: ""),
            image: UIImage(systemName: "rectangle.stack.fill"),
            selectedImage: nil
        )

        // MARK: - CartViewController

        let cartViewController = CartViewController()
        let cartNavigationController = UINavigationController(rootViewController: cartViewController)
        cartNavigationController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.cart", comment: ""),
            image: UIImage(named: "cart"),
            selectedImage: nil
        )

        // MARK: - StatisticsViewController

        let statisticsViewController = StatisticsViewController()
        let statisticsNavigationController = UINavigationController(rootViewController: statisticsViewController)
        statisticsNavigationController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.statistics", comment: ""),
            image: UIImage(systemName: "flag.2.crossed.fill"),
            selectedImage: nil
        )

        self.viewControllers = [
            profileNavigationController,
            catalogViewController,
            cartNavigationController,
            statisticsNavigationController
        ]
        
        tabBar.unselectedItemTintColor = .segmentActive
        view.backgroundColor = .backgroundColorActive
    }
}
