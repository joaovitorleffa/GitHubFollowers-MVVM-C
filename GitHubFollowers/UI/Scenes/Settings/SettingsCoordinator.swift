//
//  SettingsCoordinator.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SettingsViewController()
        vc.viewModel = SettingsViewModel()
        vc.tabBarItem = UITabBarItem(title: Strings.tabBarSettingsTitle(), image: UIImage(systemName: "gearshape.fill"), tag: 2)
        navigationController.pushViewController(vc, animated: false)
    }
}
