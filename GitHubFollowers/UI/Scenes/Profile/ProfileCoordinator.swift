//
//  ProfileCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit

protocol ProfileCoordinatorDelegate: Coordinator {
    func goToRepository(url: String)
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
        vc.viewModel = RepositoriesViewModel(username: username, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToRepository(url: String) {
        let url = URL(string: url)
        let vc = RepositoryViewController()
        vc.viewModel = RepositoryViewModel(repositoryUrl: url)
        navigationController.pushViewController(vc, animated: true)
    }
}

