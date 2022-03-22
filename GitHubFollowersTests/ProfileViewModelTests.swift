//
//  ProfileViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 22/03/22.
//

import XCTest
@testable import GitHubFollowers

class ProfileViewModelTests: XCTestCase {

    var coordinator: ProfileCoordinatorSpy!
    var requester: RequesterProtocol!
    var sut: ProfileViewModelProtocol!
    
    override func setUp() {
        coordinator = ProfileCoordinatorSpy(navigationController: UINavigationController())
        requester = RequesterStub(success: User.dummy())
        sut = ProfileViewModel(username: "joaovitorleffa", coordinator: coordinator, requester: requester)
    }
    
    func test_fetchUsers_onInitWithSuccess() {
        XCTAssertEqual(sut.username, "joaovitorleffa")
        XCTAssertEqual(sut.user.value, User.dummy())
        XCTAssertFalse(sut.isError.value)
        XCTAssertFalse(sut.isLoading.value)
    }
    
    func test_fetchUser_onInitWithError() {
        requester = RequesterStub(error: .invalidData)
        sut = ProfileViewModel(username: "joaovitorleffa", coordinator: coordinator, requester: requester)
        
        XCTAssertEqual(sut.username, "joaovitorleffa")
        XCTAssertNil(sut.user.value)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertTrue(sut.isError.value)
    }
    
    func test_getRepositories_callCoordinator() {
        sut.getRepositories()
        
        XCTAssertEqual(coordinator.goToRepositoriesCalledWith, "joaovitorleffa")
    }
}
