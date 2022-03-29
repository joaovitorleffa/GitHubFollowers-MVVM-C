//
//  FavoritesCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit

class FavoritesCoordinator: NSObject, Coordinator {
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

extension FavoritesCoordinator: FollowersFlux {
    func showErrorAlert() {
        navigationController.presentDefaultError()
    }
    
    func goToFollowers(by username: String) {
        let vc = FollowersListViewController()
        vc.viewModel = FollowersListViewModel(username: username, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfile(by username: String) {
        let coordinator = ProfileCoordinator(username: username, navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

// TODO: implementar protocolo AlertFlux
extension FavoritesCoordinator: AlertFlux {
    func showAlert(title: String, message: String, buttonTitle: String) {
        navigationController.presentGFAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
}

extension FavoritesCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.contains(fromViewController) { return }
        
        // MARK: remove ProfileCoordinator from childCoordinators when user press back button in ProfileViewController
        if let profileViewController = fromViewController as? ProfileViewController, let coordinator = profileViewController.viewModel?.coordinator {
            cleanDidFinish(coordinator)
        }
    }
}
