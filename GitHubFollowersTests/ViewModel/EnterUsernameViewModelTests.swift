//
//  EnterUsernameViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 18/03/22.
//

import XCTest
@testable import GitHubFollowers

class EnterUsernameViewModelTests: XCTestCase {

    var coordinator: SearchCoordinatorSpy!
    var sut: EnterUsernameViewModel!
    
    
    override func setUp() {
        coordinator = SearchCoordinatorSpy(navigationController: UINavigationController())
        sut = EnterUsernameViewModel()
        sut.findFollowers = { text in
            self.coordinator.findFollowers(by: text)
        }
    }

    func test_findFollowers_ShouldCallCoordinator() {
        sut.findFollowers?("joaovitorleffa")

        XCTAssertEqual(coordinator.findFollowersCalledWith, "joaovitorleffa")
    }

}
