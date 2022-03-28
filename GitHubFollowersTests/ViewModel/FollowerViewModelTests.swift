//
//  FollowerViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 28/03/22.
//

import XCTest
@testable import GitHubFollowers

class FollowerViewModelTests: XCTestCase {

    var sut: FollowerViewModelProtocol!
    var dummy = Follower.dummy()
    
    override func setUp() {
        sut = FollowerViewModel(follower: dummy, goToProfile: {})
    }

    func test_props() {
        XCTAssertEqual(sut.avatarUrl, dummy.avatarURL)
        XCTAssertEqual(sut.username, dummy.login)
    }
}
