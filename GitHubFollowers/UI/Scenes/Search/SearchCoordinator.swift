//
//  SearchCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func goToFollowers(by text: String)
    func goToProfile(by username: String)
    func showAlert(title: String, message: String, buttonTitle: String)
}

class SearchCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let vc = EnterUsernameViewController()
        let viewModel = EnterUsernameViewModel()
        viewModel.findFollowers = { [weak self] text in
            self?.goToFollowers(by: text)
        }
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
}

extension SearchCoordinator: FollowersFlux {
    func goToFollowers(by username: String) {
        if !username.isEmpty {
            let vc = FollowersListViewController()
            vc.viewModel = FollowersListViewModel(username: username, coordinator: self)
            navigationController.pushViewController(vc, animated: true)
            return
        }
        
        let viewModel = GFAlertVM(model: Alert(title: Strings.errorUsernameTitle(),
                                               message: Strings.errorUsernameMessage(),
                                               buttonTitle: Strings.errorUsernameBtnTitle()))
        let vc = GFAlertVC()
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func goToProfile(by username: String) {
        let coordinator = ProfileCoordinator(username: username, navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension SearchCoordinator: AlertFlux {
    func showErrorAlert() {}
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        navigationController.presentGFAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
}

extension SearchCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.contains(fromViewController) { return }
        
        // MARK: remove ProfileCoordinator from childCoordinators when user press back button in ProfileViewController
        if let profileViewController = fromViewController as? ProfileViewController, let coordinator = profileViewController.viewModel?.coordinator {
            cleanDidFinish(coordinator)
        }
    }
}
