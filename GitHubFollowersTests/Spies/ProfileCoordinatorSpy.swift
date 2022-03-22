//
//  ProfileCoordinatorSpy.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 22/03/22.
//

import Foundation
@testable import GitHubFollowers
import UIKit

class ProfileCoordinatorSpy: ProfileCoordinatorDelegate {
    var startCalled = false
    var goToRepositoriesCalledWith: String?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCalled = true
    }
    
    func goToRepositories(by username: String) {
        goToRepositoriesCalledWith = username
    }
}
