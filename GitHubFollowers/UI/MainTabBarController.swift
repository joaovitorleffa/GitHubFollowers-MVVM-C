//
//  MainTabBarController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

class UINavigationControllerTheme: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        startObserving(&UserInterfaceStyleManager.shared)
    }
}

class MainTabBarController: UITabBarController {
    let search = SearchCoordinator(navigationController: UINavigationControllerTheme())
    let favorites = FavoritesCoordinator(navigationController: UINavigationController())
    let settings = SettingsCoordinator(navigationController: UINavigationControllerTheme())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObserving(&UserInterfaceStyleManager.shared)
        
        search.start()
        favorites.start()
        settings.start()
        
        viewControllers = [search.navigationController, favorites.navigationController, settings.navigationController]
    }
}
