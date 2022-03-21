//
//  SearchCoordinatorSpy.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 18/03/22.
//

import Foundation
import UIKit
@testable import GitHubFollowers

class SearchCoordinatorSpy: Coordinator {
    var startCaleed: Bool = false
    var findFollowersCalledWith: String?
    var goToProfileCalledWith: String?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCaleed = true
    }
}

extension SearchCoordinatorSpy: SearchCoordinatorDelegate {
    func findFollowers(by text: String) {
        findFollowersCalledWith = text
    }
    
    func goToProfile(by username: String) {
        goToProfileCalledWith = username
    }
}
