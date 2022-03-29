//
//  FavoritesCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit

protocol FavoritesCoordinatorDelegate: AnyObject {
    func showErrorAlert()
}

class FavoritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavoritesListViewController()
        vc.viewModel = FavoritesListViewModel(coordinator: self)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
}

extension FavoritesCoordinator: FavoritesCoordinatorDelegate {
    func showErrorAlert() {
        navigationController.presentDefaultError()
    }
}
