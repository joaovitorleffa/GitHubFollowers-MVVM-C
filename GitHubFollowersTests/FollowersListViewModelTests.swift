//
//  FollowersListViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 18/03/22.
//

import XCTest
@testable import GitHubFollowers

class FollowersListViewModelTests: XCTestCase {

    var coordinator: SearchCoordinatorSpy!
    var requester: RequesterProtocol!
    var sut: FollowersListViewModelProtocol!
    
    var dummy = [Follower.dummy()]
    
    override func setUp() {
        coordinator = SearchCoordinatorSpy(navigationController: UINavigationController())
        requester = RequesterStub(success: dummy)
        sut = FollowersListViewModel(username: "any", coordinator: coordinator, requester: requester)
    }

    func test_fetchFollowers_onInitWithSuccess() {
        XCTAssertEqual(sut.followers.value, dummy)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertFalse(sut.isError.value)
    }
    
    func test_filterBy_returnFollower() {
        sut.filter(by: "joao")
        
        XCTAssertEqual(sut.followers.value, dummy)
    }
    
    func test_filterBy_returnEmpty() {
        sut.filter(by: "semcorrespondencia")
        
        XCTAssertTrue(sut.followers.value.isEmpty)
    }
    
    func test_reloadData() {
        sut.filter(by: "semcorrespondencia")
        
        sut.reloadData()
        
        XCTAssertEqual(sut.followers.value, dummy)
    }
}
