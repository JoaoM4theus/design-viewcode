//
//  MainTabBarController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit

enum ItemsTabBarController {
    case item(UIViewController, title: String, icon: String)
    
    var values: (
        viewController: UIViewController,
        title: String,
        icon: String
    ) {
        switch self {
        case .item(let viewController, let title, let icon):
            return (viewController, title, icon)
        }
    }
}

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultTabBar()
        tabBar.tintColor = UIColor(named: "TabBarTint")
        tabBar.isTranslucent = true
    }

    private func configureDefaultTabBar(
        _ items: [ItemsTabBarController] = [
            .item(HomeViewController(), title: "Learn Now", icon: "house.fill"),
            .item(ExploreViewController(), title: "Explore", icon: "magnifyingglass"),
            .item(NotificationsViewController(), title: "Notifications", icon: "bell.fill"),
            .item(LibraryViewController(), title: "Library", icon: "rectangle.stack.badge.play.fill")
        ]
    ) {
        var viewControllers: [UINavigationController] = []
        items.forEach { item in
            let navigationController = UINavigationController(rootViewController: item.values.viewController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.isTranslucent = true
            navigationController.navigationBar.backgroundColor = .clear
            navigationController.title = item.values.title
            navigationController.tabBarItem.image = UIImage(systemName: item.values.icon)
            viewControllers.append(navigationController)
        }
        
        setViewControllers(viewControllers, animated: true)
    }
}
