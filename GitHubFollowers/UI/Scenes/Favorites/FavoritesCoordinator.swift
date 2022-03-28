//
//  FavoritesCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit
 
class FavoritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavoritesListViewController()
        vc.viewModel = FavoritesListViewModel()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
}
