//
//  ProfileCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit

protocol ProfileCoordinatorDelegate: Coordinator {
    func goToRepositories(by username: String)
}

class ProfileCoordinator: ProfileCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var username: String
    
    init(username: String, navigationController: UINavigationController) {
        self.username = username
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController()
        vc.viewModel = ProfileViewModel(username: username, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToRepositories(by username: String) {
        let vc = RepositoriesViewController()
        vc.viewModel = RepositoriesViewModel(username: username)
        navigationController.pushViewController(vc, animated: true)
    }
}

