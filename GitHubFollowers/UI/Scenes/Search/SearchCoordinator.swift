//
//  SearchCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EnterUsernameViewController()
        let viewModel = EnterUsernameViewModel()
        viewModel.findFollowers = { [weak self] text in
            self?.findFollowers(by: text)
        }
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func findFollowers(by text: String) {
        if !text.isEmpty {
            let vc = FollowersListViewController()
            vc.viewModel = FollowersListViewModel(username: text)
            navigationController.pushViewController(vc, animated: true)
            return
        }
        
        let viewModel = GFAlertVM(model: Alert(title: strings.errorUsernameTitle(),
                                               message: strings.errorUsernameMessage(),
                                               buttonTitle: strings.errorUsernameBtnTitle()))
        let vc = GFAlertVC()
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
}
